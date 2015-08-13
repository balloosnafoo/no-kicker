class Player < ActiveRecord::Base
  validates :fname, :lname, :position, :team_name, presence: true

  has_many :player_contracts
  has_many :teams, through: :player_contracts, source: :team

  def players_with_ownership(league_id)
    Player.all.includes()
  end
end
