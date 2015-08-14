json.array! @leagues do |league|
  json.extract! league, :name, :id, :num_teams, :public, :redraft
  if @user_leagues
    json.user_team do
      team = league.teams.find { |team| team.manager_id == current_user.id }
      json.name team.name
      json.id team.id
    end
  end
end
