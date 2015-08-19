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
    @message = Message.find(params[:id])
    render json: @message # this is going to have to be a jbuilder later
  end

  private
  def message_params
    params.require(:message).permit(:league_id, :title, :body)
  end
end
