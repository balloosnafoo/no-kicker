class Team < ActiveRecord::Base
  validates :league, :name, presence: true

  belongs_to :league
end
