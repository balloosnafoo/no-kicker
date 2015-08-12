class Team < ActiveRecord::Base
  validates :league, :name, presence: true

  has_many :player_contracts
  has_many :players, through: :player_contracts, source: :player

  belongs_to :league
  belongs_to(
    :manager,
    class_name: "User",
    foreign_key: :manager_id,
    primary_key: :id
  )
end
