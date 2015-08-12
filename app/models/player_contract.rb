class PlayerContract < ActiveRecord::Base
  validates :team, :player, presence: true

  belongs_to :team, dependent: :destroy
  belongs_to :player, dependent: :destroy
end
