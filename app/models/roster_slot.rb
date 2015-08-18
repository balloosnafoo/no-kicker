class RosterSlot < ActiveRecord::Base
  validates :team, presence: true
  validate :team_under_limit

  belongs_to :team
  belongs_to :player

  private
  def team_under_limit
    count = team.roster_slots.where(roster_slots: { position: position }).count
    limit = team.league.roster_rule.send("num_#{position}")
    unless count < limit || position == "bench"
      errors[:roster] << "is already filled at the #{position} position"
    end
  end
end
