class Team < ActiveRecord::Base
  validates :league, :name, :division, presence: true
  validate :user_invited_or_public
  validate :league_has_opening
  validate :user_has_no_team_in_league

  has_many :player_contracts
  has_many :players, through: :player_contracts, source: :player

  belongs_to :league
  belongs_to(
    :manager,
    class_name: "User",
    foreign_key: :manager_id,
    primary_key: :id
  )

  private
  def user_invited_or_public
    return if league.public || league.commissioner == manager
    unless league.league_invites.any?{ |invite| invite.user == manager }
      errors[:user] << "must be invited or join a public league."
    end
  end

  def league_has_opening
    if league.teams.length == league.num_teams
      errors[:league] << "is already full."
    end
  end

  def user_has_no_team_in_league
    if manager.leagues.include?(league)
      errors[:user] << "cannot create multiple teams in the same league"
    end
  end
end
