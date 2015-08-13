class Api::PlayersController < ApplicationController
  def index
    @players = Player.all
    if params[:league_id]
      @league = League.find(params[:league_id])
    end
    render :index
  end
end
