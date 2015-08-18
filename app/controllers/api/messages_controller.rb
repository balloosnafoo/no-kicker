class Api::MessagesController < ApplicationController
  def index
    league = League.find(params[:league_id])
    @messages = league.messages
    render json: @messages
  end

  def create
  end

  private
  def message_params
    params.require(:message).permit(:league_id, :title, :body)
  end
end
