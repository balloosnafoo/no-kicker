json.array! @matchups do |matchup|
  json.extract! matchup, :team_1_id, :team_2_id, :week, :league_id

  json.team_1 do
    json.extract! matchup.team_1, :name
  end

  json.team_2 do
    json.extract! matchup.team_2, :name
  end
end
