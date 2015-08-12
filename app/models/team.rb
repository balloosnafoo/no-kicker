class Team < ActiveRecord::Base
  validates :league, :name, presence: true

  belongs_to :league
  belongs_to(
    :manager,
    class_name: "User",
    foreign_key: :manager_id,
    primary_key: :id
  )
end
