json.array! @matchups do |matchup|
  json.extract! matchup, :team_1_id, :team_2_id, :week, :league_id

  json.team_1 do
    json.extract! matchup.team_1, :name
    json.score matchup.team_1_score / 100.0
  end

  json.team_2 do
    json.extract! matchup.team_2, :name
    json.score matchup.team_2_score / 100.0
  end
end
