class Api::TradeOffersController < ApplicationController
  def index
    @team = current_user.team_in_league(params[:league_id])
    @trade_offers = @team.all_trades.includes(:trade_items, :players, :tradee, :trader)
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

  def destroy
    @trade_offer = TradeOffer.find(params[:id])
    if @trade_offer.destroy
      render json: @trade_offer
    else
      render json: @trade_offer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    fail
  end

  private
  def trade_offer_params
    params.require(:trade_offer).permit(:league_id, :tradee_id)
  end
end


# This grabs the total rushing yds and ids of all players
# WeeklyStat.select("SUM(weekly_stats.rushing_yds) as sum_rushing_yds")
#           .joins(:player).select(:player_id)
#           .group(:player_id)
#           .order("SUM(weekly_stats.rushing_yds) DESC")
