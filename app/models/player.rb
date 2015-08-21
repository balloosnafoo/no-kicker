class Player < ActiveRecord::Base
  validates :fname, :lname, :position, :team_name, presence: true

  has_many :player_contracts, dependent: :destroy
  has_many :teams, through: :player_contracts, source: :team
  has_many :roster_slots
  has_many :weekly_stats
  has_many :trade_items

  def contracts_by_league(id)
    Player.includes(:player_contracts).find_by(player_contracts: {league_id: id})
  end

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

  def self.with_seasonal_stats
    week = Week.current_week
    self.find_by_sql([<<-SQL, week])
      SELECT
        players.*,
        SUM(weekly_stats.rushing_tds)   AS rushing_tds,
        SUM(weekly_stats.rushing_yds)   AS rushing_yds,
        SUM(weekly_stats.fumbles_lost)  AS fumbles_lost,
        SUM(weekly_stats.passing_int)   AS passing_int,
        SUM(weekly_stats.passing_tds)   AS passing_tds,
        SUM(weekly_stats.passing_yds)   AS passing_yds,
        SUM(weekly_stats.receiving_rec) AS receiving_rec,
        SUM(weekly_stats.receiving_tds) AS receiving_tds,
        SUM(weekly_stats.receiving_yds) AS receiving_yds
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

  def self.with_stats_and_contracts(league_id)
    week = Week.current_week
    self.find_by_sql([<<-SQL, league_id, week])
      SELECT
        players.*,
        league_contracts.id               AS contract_id,
        league_contracts.manager_id       AS contract_owner_id,
        league_contracts.manager_username AS contract_owner_username,
        seasonal_stats.rushing_tds        AS rushing_tds,
        seasonal_stats.rushing_yds        AS rushing_yds,
        seasonal_stats.fumbles_lost       AS fumbles_lost,
        seasonal_stats.passing_int        AS passing_int,
        seasonal_stats.passing_tds        AS passing_tds,
        seasonal_stats.passing_yds        AS passing_yds,
        seasonal_stats.receiving_rec      AS receiving_rec,
        seasonal_stats.receiving_tds      AS receiving_tds,
        seasonal_stats.receiving_yds      AS receiving_yds,

        (seasonal_stats.rushing_tds * 600) +
        (seasonal_stats.rushing_yds * 10) +
        (seasonal_stats.fumbles_lost * -200) +
        (seasonal_stats.passing_int * -200) +
        (seasonal_stats.passing_tds * 600) +
        (seasonal_stats.passing_yds * 5) +
        (seasonal_stats.receiving_rec * 0) +
        (seasonal_stats.receiving_tds * 600) +
        (seasonal_stats.receiving_yds * 10) AS fantasy_points

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
      JOIN (
        SELECT
          players.id,
          SUM(weekly_stats.rushing_tds)   AS rushing_tds,
          SUM(weekly_stats.rushing_yds)   AS rushing_yds,
          SUM(weekly_stats.fumbles_lost)  AS fumbles_lost,
          SUM(weekly_stats.passing_int)   AS passing_int,
          SUM(weekly_stats.passing_tds)   AS passing_tds,
          SUM(weekly_stats.passing_yds)   AS passing_yds,
          SUM(weekly_stats.receiving_rec) AS receiving_rec,
          SUM(weekly_stats.receiving_tds) AS receiving_tds,
          SUM(weekly_stats.receiving_yds) AS receiving_yds
        FROM
          players
        JOIN
          weekly_stats ON weekly_stats.player_id = players.id
        WHERE
          weekly_stats.week <= ?
        GROUP BY
          players.id
      ) AS seasonal_stats ON players.id = seasonal_stats.id
      ORDER BY
        seasonal_stats.rushing_yds + seasonal_stats.receiving_yds + (seasonal_stats.passing_yds / 3) DESC
    SQL
  end
end

# sq = PlayerContract.select("player_contracts.*, users.*").joins(:team, :manager).where(teams: {league_id: 1})
# Player.select("players.*, player_contracts.*, users.*").joins(sq)
