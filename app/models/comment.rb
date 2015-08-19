class Comment < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )

  belongs_to :messages
end
