class League < ActiveRecord::Base
  validates :name, :public, :redraft, :type, presence: true
  validates :num_teams, minimum: 8
  validates :num_teams, maximum: 3

  has_many :teams
  # has_one :commissioner
  # has_one :rule_set
end
