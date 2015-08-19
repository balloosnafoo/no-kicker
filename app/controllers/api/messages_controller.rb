class Api::MessagesController < ApplicationController
  def index
    league = League.find(params[:league_id])
    @messages = league.messages
    render json: @messages
  end

  def create
    @message = current_user.authored_messages.create(message_params)
    render json: @message
  end

  def show
    @message = Message.includes(:comments).find(params[:id])
    render :show
  end

  private
  def message_params
    params.require(:message).permit(:league_id, :title, :body)
  end
end
