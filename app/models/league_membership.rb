class LeagueMembership < ActiveRecord::Base
  validates :league, :member, presence: true

  belongs_to :league
  belongs_to(
    :member,
    class_name: "User",
    foreign_key: :member_id,
    primary_key: :id
  )
end
