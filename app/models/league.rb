class League < ActiveRecord::Base
  validates :name, :match_type, presence: true
  validates :public, :redraft, inclusion: { in: [ true, false ] }
  validates :num_teams, numericality: { greater_than: 8 }
  validates :num_divisions, numericality: { less_than: 4 }

  has_many :teams
  has_many :members, through: :teams, source: :manager

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

  def generate_matchups
    # Assuming only one division for now
    num_teams.times do |i|
      games = []
      counter = 0
      while games.length < 14 # later should be num_weeks
        opp_idx = (i + counter + 1) % num_teams
        counter += 1
        next if opp_idx == i
        games << [i, opp_idx]
      end
    end
  end
end
