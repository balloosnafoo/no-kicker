json.extract!(
  @league,
  :id, :name, :num_divisions, :redraft, :public,
  :num_teams, :commissioner_id, :match_type
)

# TODO: Eliminate the first branch of this condional and the few functions
# that depend on it (at least TeamAddDrop does, as it was implemented before
# roster slots).

if !@detail
  if @team && !@as_roster_slots
    json.user_team do
      json.extract! @team, :id, :name
      json.players do
        json.array! @team.players do |player|
          json.extract! player, :id, :fname, :lname, :team_name, :position
          json.contract do
            json.id @team.player_contracts.find_by(player_id: player.id).id
          end
          json.stats do
            total_points = 0
            rushing_tds_tot = player.total("rushing_tds", @week)
            total_points += rushing_tds_tot * @score_rule.rushing_tds
            rushing_yds_tot = player.total("rushing_yds", @week)
            total_points += rushing_yds_tot * @score_rule.rushing_yds
            fumbles_lost_tot = player.total("fumbles_lost", @week)
            total_points += fumbles_lost_tot * @score_rule.fumbles_lost
            passing_int_tot = player.total("passing_int", @week)
            total_points += passing_int_tot * @score_rule.passing_int
            passing_tds_tot = player.total("passing_tds", @week)
            total_points += passing_tds_tot * @score_rule.passing_tds
            passing_yds_tot = player.total("passing_yds", @week)
            total_points += passing_yds_tot * @score_rule.passing_yds
            receiving_rec_tot = player.total("receiving_rec", @week)
            total_points += receiving_rec_tot * @score_rule.receiving_rec
            receiving_tds_tot = player.total("receiving_tds", @week)
            total_points += receiving_tds_tot * @score_rule.receiving_tds
            receiving_yds_tot = player.total("receiving_yds", @week)
            total_points += receiving_yds_tot * @score_rule.receiving_yds

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
  elsif @team && @as_roster_slots
    json.user_team do
      json.extract! @team, :id, :league_id, :manager_id, :name
      belongs_to_user = current_user.id == @team.id
      json.belongs_to_user belongs_to_user

      json.roster_slots do
        positions = ["qb", "rb", "wr", "te", "flex", "dst", "k", "bench"]
        positions.each do |pos|
          slots = @team.roster_slots.where(roster_slots: { position: pos })
          json.array! slots do |slot|
            json.extract! slot, :id, :position, :team_id, :order
            if slot.player
              player = slot.player
              json.player do
                json.extract! slot.player, :fname, :lname, :position, :id, :team_name
                json.stats do
                  total_points = 0
                  rushing_tds_tot = player.total("rushing_tds")
                  total_points += rushing_tds_tot * @score_rule.rushing_tds
                  json.rushing_tds rushing_tds_tot

                  rushing_yds_tot = player.total("rushing_yds")
                  total_points += rushing_yds_tot * @score_rule.rushing_yds
                  json.rushing_yds rushing_tds_tot

                  fumbles_lost_tot = player.total("fumbles_lost")
                  total_points += fumbles_lost_tot * @score_rule.fumbles_lost
                  json.fumbles_lost fumbles_lost_tot

                  passing_int_tot = player.total("passing_int")
                  total_points += passing_int_tot * @score_rule.passing_int
                  json.passing_int passing_int_tot

                  passing_tds_tot = player.total("passing_tds")
                  total_points += passing_tds_tot * @score_rule.passing_tds
                  json.passing_tds passing_tds_tot

                  passing_yds_tot = player.total("passing_yds")
                  total_points += passing_yds_tot * @score_rule.passing_yds
                  json.passing_yds passing_yds_tot

                  receiving_rec_tot = player.total("receiving_rec")
                  total_points += receiving_rec_tot * @score_rule.receiving_rec
                  json.receiving_rec receiving_rec_tot

                  receiving_tds_tot = player.total("receiving_tds")
                  total_points += receiving_tds_tot * @score_rule.receiving_tds
                  json.receiving_tds receiving_tds_tot

                  receiving_yds_tot = player.total("receiving_yds")
                  total_points += receiving_yds_tot * @score_rule.receiving_yds
                  json.receiving_yds receiving_yds_tot

                  json.total_fantasy total_points / 100.0
                  json.ave_fantasy (total_points / 3) / 100.0
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

    end
  else
    json.teams do
      json.array! @league.teams do |team|
        win_count = team.win_count
        loss_count = @week - win_count
        win_percent = ((win_count * 1.0) / @week).round(2)

        json.extract! team, :name, :id
        json.manager_username team.manager.username
        json.win_count win_count
        json.loss_count loss_count
        json.win_percent win_percent
        json.games_behind @best_record - win_count

        tot_points = team.total_points
        json.total_points_for tot_points / 100.0
        json.ave_points_for ((tot_points / 100.0) / @week).round(2)

        tot_points_against = team.total_points_against
        json.total_points_against tot_points_against / 100.0
        json.ave_points_against ((tot_points_against / 100.0) / @week).round(2)

        unless @league.matchups.empty?
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
end
