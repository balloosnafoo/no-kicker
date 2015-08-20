class TradeItem < ActiveRecord::Base
  validates :player_id, :owner_id, :trade_offer, presence: true

  belongs_to :trade_offer
end
