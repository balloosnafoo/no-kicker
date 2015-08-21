class Player < ActiveRecord::Base
  validates :fname, :lname, :position, :team_name, presence: true

  has_many :player_contracts, dependent: :destroy
  has_many :teams, through: :player_contracts, source: :team
  has_many :roster_slots
  has_many :weekly_stats
  has_many :trade_items

  def self.with_league_contracts(league_id)
    self.find_by_sql([<<-SQL, league_id])
      SELECT
        players.*,
        league_contracts.id AS contract_id,
        league_contracts.manager_id AS contract_owner_id,
        league_contracts.manager_username AS contract_owner_username
      FROM
        players
      LEFT OUTER JOIN (
        SELECT
          player_contracts.*, users.id AS manager_id, users.username AS manager_username
        FROM
          player_contracts
        JOIN
          teams ON player_contracts.team_id = teams.id
        JOIN
          users ON teams.manager_id = users.id
        WHERE
          teams.league_id = ?
      ) AS league_contracts ON players.id = league_contracts.player_id
    SQL
  end

  # super unfinished
  def self.with_seasonal_stats
    week = Week.current_week
    self.find_by_sql([<<-SQL, week])
      SELECT
        players.*,
        SUM(weekly_stats.rushing_tds) AS rushing_tds,
        SUM(weekly_stats.rushing_yds) AS rushing_yds
      FROM
        players
      JOIN
        weekly_stats ON weekly_stats.player_id = players.id
      WHERE
        weekly_stats.week <= ?
      GROUP BY
        players.id
    SQL
  end
end

# sq = PlayerContract.select("player_contracts.*, users.*").joins(:team, :manager).where(teams: {league_id: 1})
# Player.select("players.*, player_contracts.*, users.*").joins(sq)
