class PlayerContract < ActiveRecord::Base
  validates :team, :player, presence: true

  belongs_to :team
  belongs_to :player
end
