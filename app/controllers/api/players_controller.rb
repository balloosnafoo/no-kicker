class Api::PlayersController < ApplicationController
  def index
    if params[:league_id]
      @players = Player.with_stats_and_contracts(params[:league_id])
      @week = Week.current_week
      @league_specific = true
    else
      @players = Player.all
    end
    render :index
  end

  def show
    @player = Player.find(params[:id])
    @league = League.includes(:score_rule).find(params[:league_id]) if params[:league_id]
    @week = Week.current_week
    render :show
  end
end
