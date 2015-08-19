class TradeItem < ActiveRecord::Base
  validates :player, :owner, :trade_offer, presence: true

  belongs_to :trade_offer
end
