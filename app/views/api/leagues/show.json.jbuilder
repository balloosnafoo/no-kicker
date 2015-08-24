json.extract!(
  @league,
  :id, :name, :num_divisions, :redraft, :public,
  :num_teams, :commissioner_id, :match_type
)

# TODO: Eliminate the first branch of this condional and the few functions
# that depend on it (at least TeamAddDrop does, as it was implemented before
# roster slots).

week = Week.current_week

if @team && !@as_roster_slots
  json.user_team do
    json.extract! @team, :id, :name
    json.players do
      json.array! @team.players
                       .includes(:player_contracts)
                       .where(player_contracts: { team_id: @team.id }) do |player|
        json.extract! player, :id, :fname, :lname, :team_name, :position
        json.contract do
          json.id player.player_contracts[0].id
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
            json.player do
              json.extract! slot.player, :fname, :lname, :position, :id, :team_name
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
      loss_count = week - win_count
      win_percent = ((win_count * 1.0) / week).round(2)

      json.extract! team, :name, :id
      json.manager_username team.manager.username
      json.win_count win_count
      json.loss_count loss_count
      json.win_percent win_percent
      json.games_behind @best_record - win_count

      tot_points = team.total_points
      json.total_points_for tot_points / 100.0
      json.ave_points_for ((tot_points / 100.0) / week).round(2)

      tot_points_against = team.total_points_against
      json.total_points_against tot_points_against / 100.0
      json.ave_points_against ((tot_points_against / 100.0) / week).round(2)

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
