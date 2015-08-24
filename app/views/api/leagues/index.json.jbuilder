json.array! @leagues do |league|
  best_record = league.best_record
  json.extract! league, :name, :id, :num_teams, :public, :redraft
  if @user_leagues
    json.best_record best_record
    json.user_team do
      team = league.teams.find { |team| team.manager_id == current_user.id }
      json.name team.name
      json.id team.id

      win_count = team.win_count
      json.wins win_count
      json.losses @week - win_count
      json.win_percent (win_count / (@week * 1.0)).round(2)

      unless team.matchups.empty?
        prev_matchup = team.prev_matchup
        prev_opp = prev_matchup.team_1_id != team.id ? prev_matchup.team_1 : prev_matchup.team_2

        next_matchup = team.next_matchup
        next_opp = next_matchup.team_1_id != team.id ? next_matchup.team_1 : next_matchup.team_2

        json.prev_opp prev_opp.name
        json.prev_opp_id prev_opp.id
        json.next_opp next_opp.name
        json.next_opp_id next_opp.id
      end
    end
  end
end
