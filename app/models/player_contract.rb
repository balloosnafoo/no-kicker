class PlayerContract < ActiveRecord::Base
  validates :team, :player, presence: true
  validate :team_has_space

  belongs_to :team
  belongs_to :player
  has_one :league, through: :team, source: :league
  has_one :manager, through: :team, source: :manager

  def team_has_space
    if team.is_full?
      errors[:roster] << "is full"
    end
  end
end
