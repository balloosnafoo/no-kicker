
json.extract! @team, :id, :league_id, :manager_id, :name
belongs_to_user = current_user.id == @team.manager.id
json.manager_username @team.manager.username
json.belongs_to_user belongs_to_user

last_update = @team.roster_slots.order(updated_at: :desc).first
json.last_roster_change time_ago_in_words(last_update.updated_at) + " ago"

if @next_matchup
  next_matchup = @next_matchup.team_1 == @team ? @next_matchup.team_2 : @next_matchup.team_1
  json.next_matchup next_matchup.name
  json.next_matchup_id next_matchup.id
else
  json.next_matchup "Unassigned"
end
json.roster_slots do
  positions = ["qb", "rb", "wr", "te", "flex", "dst", "k", "bench"]
  positions.each do |pos|
    slots = @roster_slots.where(roster_slots: { position: pos })
    json.array! slots do |slot|
      json.extract! slot, :id, :position, :team_id, :order
      if slot.player
        json.player do
          player = slot.player
          league_contract = player.player_contracts.find_by(league_id: @team.league_id)

          json.extract! player, :fname, :lname, :position, :id, :team_name

          json.contract do
            json.extract! league_contract, :id
          end

          json.stats do
            # fpoints_s = player.fantasy_points.to_s
            # fpoints_s = "#{fpoints_s[0..-3]}.#{fpoints_s[-3..-2]}"
            # ave_fpoints_s = (player.fantasy_points / (Week.current_week)).to_s
            # ave_fpoints_s = "#{ave_fpoints_s[0..-3]}.#{ave_fpoints_s[-3..-2]}"

            total_points = 0
            rushing_tds_tot = player.total("rushing_tds", @week)
            json.rushing_tds rushing_tds_tot
            total_points += rushing_tds_tot * @score_rule.rushing_tds

            rushing_yds_tot = player.total("rushing_yds", @week)
            total_points += rushing_yds_tot * @score_rule.rushing_yds
            json.rushing_yds rushing_tds_tot

            fumbles_lost_tot = player.total("fumbles_lost", @week)
            total_points += fumbles_lost_tot * @score_rule.fumbles_lost
            json.fumbles_lost fumbles_lost_tot

            passing_int_tot = player.total("passing_int", @week)
            total_points += passing_int_tot * @score_rule.passing_int
            json.passing_int passing_int_tot

            passing_tds_tot = player.total("passing_tds", @week)
            total_points += passing_tds_tot * @score_rule.passing_tds
            json.passing_tds passing_tds_tot

            passing_yds_tot = player.total("passing_yds", @week)
            total_points += passing_yds_tot * @score_rule.passing_yds
            json.passing_yds passing_yds_tot

            receiving_rec_tot = player.total("receiving_rec", @week)
            total_points += receiving_rec_tot * @score_rule.receiving_rec
            json.receiving_rec receiving_rec_tot

            receiving_tds_tot = player.total("receiving_tds", @week)
            total_points += receiving_tds_tot * @score_rule.receiving_tds
            json.receiving_tds receiving_tds_tot

            receiving_yds_tot = player.total("receiving_yds", @week)
            total_points += receiving_yds_tot * @score_rule.receiving_yds
            json.receiving_yds receiving_yds_tot

            json.total_fantasy total_points / 100.0
            json.ave_fantasy (total_points / 3) / 100.0
            # json.fantasy_points fpoints_s
            # json.ave_fantasy_points ave_fpoints_s
          end
          json.info do
            next_game = player.next_game
            next_opp = next_game.home_team == player.team_name ? "vs#{next_game.away_team}" : "@#{next_game.home_team}"
            json.next_opp next_opp
          end
        end
      end
    end
  end
end
json.roster_rule do
  json.extract! @team.roster_rule, :num_qb, :num_wr, :num_rb, :num_te, :num_flex,
                                  :num_dst, :num_k, :num_bench
end
