class TradeOffer < ActiveRecord::Base
  validates :league, :trader, :tradee, presence: true

  belongs_to :league

  belongs_to(
    :trader,
    class_name: "Team",
    foreign_key: :trader_id,
    primary_key: :id
  )

  belongs_to(
    :tradee,
    class_name: "Team",
    foreign_key: :tradee_id,
    primary_key: :id
  )

  has_many :trade_items
end
