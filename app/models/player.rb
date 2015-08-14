class Player < ActiveRecord::Base
  validates :fname, :lname, :position, :team_name, presence: true

  has_many :player_contracts, dependent: :destroy
  has_many :teams, through: :player_contracts, source: :team

  def self.with_league_contracts(league_id)
    self.find_by_sql([<<-SQL, league_id])
      SELECT
        players.*, league_contracts.id AS contract_id, league_contracts.manager_id AS contract_owner_id
      FROM
        players
      LEFT OUTER JOIN (
        SELECT
          player_contracts.*, users.id AS manager_id
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

  def players_with_ownership(league_id)
    Player.all.includes()
  end
end
