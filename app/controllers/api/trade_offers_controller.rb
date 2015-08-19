class Api::TradeOffersController < ApplicationController
  def index
    team = current_user.team_in_league(params[:league_id])
    @trade_offers = team.all_trades.includes(:trade_items)
    render :index
  end
end
