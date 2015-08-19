json.extract! @message, :author_id, :league_id, :title, :body
json.comments do
  json.array! @message.comments do |comment|
    json.extract! comment, :author_id, :message_id, :parent_id, :body
  end
end
