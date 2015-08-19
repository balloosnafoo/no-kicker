class Message < ActiveRecord::Base
  belongs_to :league
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :comments
end
