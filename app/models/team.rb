class Team < ActiveRecord::Base
  validates :league, :name, :division, presence: true
  validate :user_invited_or_public
  validate :league_has_opening
  validate :user_has_no_team_in_league

  has_many :player_contracts, dependent: :destroy
  has_many :players, through: :player_contracts, source: :player
  has_many :roster_slots

  has_many(
    :home_matchups,
    class_name: "Matchup",
    foreign_key: :team_1_id,
    primary_key: :id
  )
  has_many(
    :away_matchups,
    class_name: "Matchup",
    foreign_key: :team_2_id,
    primary_key: :id
  )

  belongs_to :league
  belongs_to(
    :manager,
    class_name: "User",
    foreign_key: :manager_id,
    primary_key: :id
  )

  def matchups
    Matchup.where("team_1_id = ? OR team_2_id = ?", id, id)
  end

  def is_full?
    league.team_size_limit <= player_contracts.length
  end

  def assign_or_create_roster_slot(player)
    starting_slots = find_starting_slots(player.position)
    unless starting_slots.empty?
      starting_slots[0].update(player_id: player.id)
    else
      bench_slots = find_bench_slot
      bench_slots[0].update(player_id: player.id)
    end
  end

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
      errors[:manager] << "cannot create multiple teams in the same league"
    end
  end

  def find_starting_slots(position)
    slots = roster_slots.where(
      roster_slots: {
        position: position.downcase,
        player_id: nil
      }
    )
    if slots.empty? && ["wr", "rb", "te"].include?(position.downcase)
      slots = roster_slots.where(
        roster_slots: {
          position: "flex",
          player_id: nil
        }
      )
    end
    slots
  end

  def find_bench_slot
    bench_slots = roster_slots.where(
      roster_slots: {
        position: "bench",
        player_id: nil
      }
    )
  end
end
