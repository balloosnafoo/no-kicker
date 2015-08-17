class RosterSlot < ActiveRecord::Base
  validates :team, presence: true

  belongs_to :team
  belongs_to :player
end
