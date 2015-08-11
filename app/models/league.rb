class League < ActiveRecord::Base
  validates :name, presence: true

  has_many :teams
  # has_one :commissioner
  # has_one :rule_set
end
