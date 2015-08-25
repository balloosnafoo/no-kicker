json.extract! @message, :author_id, :league_id, :title, :body
json.comments do
  json.array! @message.comments do |comment|
    json.extract! comment, :author_id, :message_id, :parent_id, :body
    json.ago_in_words time_ago_in_words(comment.created_at) + " ago by"
    json.author_username comment.author.username
  end
end
