json.array! @messages do |message|
  json.extract! message, :id, :title, :body, :author_id, :league_id
  json.comment_count message.comments.count
  json.author_username message.author.username
  json.created_at time_ago_in_words(message.created_at) + " ago by"
end
