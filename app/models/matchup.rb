class Matchup < ActiveRecord::Base
  validates :team_1_id, :team_2_id, :week, presence: true # not testing that actual teams exist in order to test matchup scheduler.

  belongs_to(
    :team_1,
    class_name: "Team",
    foreign_key: :team_1_id,
    primary_key: :id
  )

  belongs_to(
    :team_2,
    class_name: "Team",
    foreign_key: :team_1_id,
    primary_key: :id
  )
end
