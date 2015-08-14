json.extract! @team, :id, :league_id, :manager_id, :name
json.players do
  json.array! @team.players do |player|
    json.extract! player, :fname, :lname, :position, :id, :team_name
  end
end
