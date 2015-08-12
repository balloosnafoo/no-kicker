json.array! @leagues do |league|
  json.extract! league, :name
  json.user_team do
    json.name league.teams[0].name
  end
end
