class League < ActiveRecord::Base
  validates :name, :public, :redraft, :match_type, presence: true
  validates :num_teams, numericality: { greater_than: 8 }
  validates :num_divisions, numericality: { less_than: 4 }

  has_many :teams
  has_one(
    :rule_set,
    class_name: "RuleSet",
    foreign_key: :league_id,
    primary_key: :id
  )

  belongs_to(
    :commissioner,
    class_name: "User",
    foreign_key: :commissioner_id,
    primary_key: :id
  )
end
