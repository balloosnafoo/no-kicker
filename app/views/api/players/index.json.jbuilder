json.array! @players do |player|
  json.extract! player, :id, :fname, :lname, :position, :team_name
  if @league_specific && player.contract_id
    user_player = player.contract_owner_id == current_user.id
    json.contract do
      json.id player.contract_id
      json.contract_owner_id player.contract_owner_id
      json.user_player user_player
      json.contract_owner_username player.contract_owner_username
    end
  end
  if @league_specific
    fpoints_s = player.fantasy_points.to_s
    fpoints_s = "#{fpoints_s[0..-3]}.#{fpoints_s[-3..-2]}"
    ave_fpoints_s = (player.fantasy_points / (Week.current_week)).to_s
    ave_fpoints_s = "#{ave_fpoints_s[0..-3]}.#{ave_fpoints_s[-3..-2]}"
    json.stats do
      json.rushing_tds player.rushing_tds
      json.rushing_yds player.rushing_yds
      json.fumbles_lost player.fumbles_lost
      json.passing_int player.passing_int
      json.passing_tds player.passing_tds
      json.passing_yds player.passing_yds
      json.receiving_rec player.receiving_rec
      json.receiving_tds player.receiving_tds
      json.receiving_yds player.receiving_yds
      json.fantasy_points fpoints_s
      json.ave_fantasy_points ave_fpoints_s
    end
  end

  # contract = player.player_contracts.find_by(league_id: league.id)
  # team = player.fantasy_teams.find_by(league_id: league.id)

end
