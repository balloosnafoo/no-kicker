class League < ActiveRecord::Base
  validates :name, :public, :redraft, :match_type, presence: true
  validates :num_teams, numericality: { greater_than: 8 }
  validates :num_divisions, numericality: { less_than: 4 }

  has_many :teams
  # has_one :commissioner
  # has_one :rule_set
end
