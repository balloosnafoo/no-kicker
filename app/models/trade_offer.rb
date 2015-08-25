class TradeOffer < ActiveRecord::Base
  validates :league, :trader, :tradee, presence: true
  validate :is_n_for_n

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

  has_many :trade_items, dependent: :destroy
  has_many :players, through: :trade_items, source: :player

  private
  def is_n_for_n
    unless trade_items.where(owner_id: trader.id).count == trade_items.where(owner_id: tradee.id).count
      errors[:trades] << "must involve the same number of players from each team"
    end
  end
end
