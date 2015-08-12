json.league do
  json.extract!(
    @league,
    :id, :name, :num_divisions, :redraft, :public,
    :num_teams, :commissioner_id, :redraft
  )
end

json.teams do
  json.array! @league.teams, :name, :id
end
