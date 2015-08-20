class Api::TradeItemsController < ApplicationController
  def create
    @trade_item = TradeItem.new(trade_item_params)
    if @trade_item.save
      render json: @trade_item
    else
      render json: @trade_item.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def trade_item_params
    params.require(:trade_item).permit(:player_id, :owner_id, :trade_offer_id)
  end
end
