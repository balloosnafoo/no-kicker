class Api::TradeOffersController < ApplicationController
  def index
    team = current_user.team_in_league(params[:league_id])
    @trade_offers = team.all_trades.includes(:trade_items)
    render :index
  end

  def create
    team = current_user.team_in_league(params[:league_id])
    @trade_offer = team.offered_trades.new(trade_offer_params)
    if @trade_offer.save
      render json: @trade_offer
    else
      render json: @trade_offer.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def trade_offer_params
    params.require(:trade_offer).permit(:league_id, :tradee_id)
  end
end
