json.extract! @player, :id, :fname, :lname, :team_name, :position
json.stats do

  score_rule = @league.score_rule

  total_points = 0
  rushing_tds_tot = @player.total("rushing_tds", @week)
  total_points += rushing_tds_tot * score_rule.rushing_tds
  rushing_yds_tot = @player.total("rushing_yds", @week)
  total_points += rushing_yds_tot * score_rule.rushing_yds
  fumbles_lost_tot = @player.total("fumbles_lost", @week)
  total_points += fumbles_lost_tot * score_rule.fumbles_lost
  passing_int_tot = @player.total("passing_int", @week)
  total_points += passing_int_tot * score_rule.passing_int
  passing_tds_tot = @player.total("passing_tds", @week)
  total_points += passing_tds_tot * score_rule.passing_tds
  passing_yds_tot = @player.total("passing_yds", @week)
  total_points += passing_yds_tot * score_rule.passing_yds
  receiving_rec_tot = @player.total("receiving_rec", @week)
  total_points += receiving_rec_tot * score_rule.receiving_rec
  receiving_tds_tot = @player.total("receiving_tds", @week)
  total_points += receiving_tds_tot * score_rule.receiving_tds
  receiving_yds_tot = @player.total("receiving_yds", @week)
  total_points += receiving_yds_tot * score_rule.receiving_yds

  json.rushing_tds rushing_tds_tot
  json.rushing_yds rushing_tds_tot
  json.fumbles_lost fumbles_lost_tot
  json.passing_int passing_int_tot
  json.passing_tds passing_tds_tot
  json.passing_yds passing_yds_tot
  json.receiving_rec receiving_rec_tot
  json.receiving_tds receiving_tds_tot
  json.receiving_yds receiving_yds_tot
  json.total_fantasy total_points / 100.0
  json.ave_fantasy (total_points / 3) / 100.0
end
json.info do
  next_game = @player.next_game
  next_opp = next_game.home_team == @player.team_name ? "vs#{next_game.away_team}" : "@#{next_game.home_team}"
  json.next_opp next_opp
end
