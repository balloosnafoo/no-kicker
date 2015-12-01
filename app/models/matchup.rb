class Matchup < ActiveRecord::Base
  validates :team_1_id, :team_2_id, :week, presence: true

  belongs_to(
    :team_1,
    class_name: "Team",
    foreign_key: :team_1_id,
    primary_key: :id
  )

  belongs_to(
    :team_2,
    class_name: "Team",
    foreign_key: :team_2_id,
    primary_key: :id
  )

  has_one :league, through: :team_1, source: :league
end
