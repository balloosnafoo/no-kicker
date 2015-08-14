
json.extract!(
  @league,
  :id, :name, :num_divisions, :redraft, :public,
  :num_teams, :commissioner_id, :redraft
)

if @team
  json.user_team do
    json.extract! @team, :id, :name
    json.players do
      json.array! @team.players, :fname, :lname, :team_name, :position
    end
  end
else
  json.teams do
    json.array! @league.teams, :name, :id
  end
end
