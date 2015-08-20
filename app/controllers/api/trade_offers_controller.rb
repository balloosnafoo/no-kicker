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
    @trade_offer = TradeOffer.includes(:trader, :tradee).find(params[:id])
    if @trade_offer.update(trade_offer_params)
      given_ids    = @trade_offer.trade_items
                          .where(trade_items: { owner_id: current_user.id })
                          .pluck(:player_id)
      received_ids = @trade_offer.trade_items
                          .where.not(trade_items: { owner_id: current_user.id })
                          .pluck(:player_id)
      @trade_offer.players.includes(:player_contracts)
             .where(player_contracts: {league_id: params[:league_id]})
             .each do |player|
        if given_ids.include?(player.id)
          player.player_contracts.first.destroy()
          @trade_offer.trader.remove_player_from_starting_slot(player)
          @trade_offer.tradee.player_contracts.create(
            player_id: player.id,
            league_id: params[:league_id]
          )
          @trade_offer.tradee.assign_or_create_roster_slot(player)
        else
          player.player_contracts.first.destroy()
          @trade_offer.tradee.remove_player_from_starting_slot(player)
          @trade_offer.trader.player_contracts.create(
            player_id: player.id,
            league_id: params[:league_id]
          )
          @trade_offer.trader.assign_or_create_roster_slot(player)
        end
      end
      render json: @trade_offer
    else
      render json: @trade_offer.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def trade_offer_params
    params.require(:trade_offer).permit(:league_id, :tradee_id, :pending)
  end
end


# This grabs the total rushing yds and ids of all players
# WeeklyStat.select("SUM(weekly_stats.rushing_yds) as sum_rushing_yds")
#           .joins(:player).select(:player_id)
#           .group(:player_id)
#           .order("SUM(weekly_stats.rushing_yds) DESC")
