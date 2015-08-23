class League < ActiveRecord::Base
  validates :name, :match_type, presence: true
  validates :public, :redraft, inclusion: { in: [ true, false ] }
  validates :num_teams, numericality: { greater_than: 8 }
  validates :num_divisions, numericality: { less_than: 4 }

  has_many :teams
  has_many :members, through: :teams, source: :manager
  has_many :player_contracts
  # has_many :player_contracts, through: :teams, source: :player_contracts
  has_many :matchups
  has_many :messages

  has_one(
    :score_rule,
    class_name: "ScoreRule",
    foreign_key: :league_id,
    primary_key: :id
  )

  has_one :roster_rule

  belongs_to(
    :commissioner,
    class_name: "User",
    foreign_key: :commissioner_id,
    primary_key: :id
  )

  has_many :league_invites

  def self.users_leagues_and_teams(id)
    User.find(id)
        .leagues
        .includes(:teams)
        .where(teams: { manager_id: id })
  end

  # Maybe made obsolete by adding league_id to player_contracts
  def player_contract(player_id)
    player_contracts.find do |contract|
      contract.id if contract.player_id == player_id
    end
  end

  def team_size_limit
    roster_rule.total_slots
  end

  def generate_matchups
    return unless matchups.empty?
    team_id_arr = team_ids
    a1 = team_id_arr[0...num_teams / 2]
    a2 = team_id_arr[num_teams / 2...num_teams].reverse
    14.times do |week|
      a1.each_with_index do |_, idx|
        Matchup.create!(
          team_1_id: a1[idx],
          team_2_id: a2[idx],
          week: week,
          league_id: id
        )
      end
      a1.insert(1, a2.shift())
      a2.push(a1.pop)
    end
  end

  def team_ids
    teams.pluck(:id)
  end

  def generate_roster_slots(team)
    roster_rule.generate_roster_slots(team)
  end

  def score_player(player)
    player_stats = player.weekly_stats.find_by(week: Week.current_week + 1)
    return 0 unless player_stats
    total = 0
    stats = [
      "rushing_tds",
      "rushing_yds",
      "fumbles_lost",
      "passing_int",
      "passing_tds",
      "passing_yds",
      "receiving_rec",
      "receiving_tds",
      "receiving_yds"
    ]
    stats.each do |stat|
      # debugger
      total += player_stats.send(stat) * score_rule.send(stat)
    end
    return total
  end
end
