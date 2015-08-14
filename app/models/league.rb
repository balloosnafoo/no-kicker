class League < ActiveRecord::Base
  validates :name, :match_type, presence: true
  validates :public, :redraft, inclusion: { in: [ true, false ] }
  validates :num_teams, numericality: { greater_than: 8 }
  validates :num_divisions, numericality: { less_than: 4 }

  has_many :teams
  has_many :members, through: :teams, source: :manager
  has_many :player_contracts, through: :teams, source: :player_contracts
  has_many :matchups, through: :teams, source: :matchups

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

  def player_contract(player_id)
    player_contracts.find do |contract|
      contract.id if contract.player_id == player_id
    end
  end

  def team_size_limit
    roster_rule.total_slots
  end

  # currently using indices 0...num_teams which are not actual indices of teams.
  def generate_matchups
    return if matchups
    a1 = (0...num_teams / 2).to_a
    a2 = (num_teams / 2...num_teams).to_a.reverse
    14.times do |week|
      a1.each_with_index do |_, idx|
        Matchup.create!(
          team_1_id: a1[idx],
          team_2_id: a2[idx],
          week: week
        )
      end
      a1.insert(1, a2.shift())
      a2.push(a1.pop)
    end
  end

  def team_ids
    teams.select(:id)
  end
end
