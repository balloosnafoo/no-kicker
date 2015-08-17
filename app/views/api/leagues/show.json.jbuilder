
json.extract!(
  @league,
  :id, :name, :num_divisions, :redraft, :public,
  :num_teams, :commissioner_id, :redraft
)

if @team
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

      # Include contract id here, without it contract can't be destroyed.
    end
  end
else
  json.teams do
    json.array! @league.teams, :name, :id
  end
end


# json.array! @team.players
#                  .includes(:player_contracts)
#                  .where(player_contract: { team_id: @team.id }),
#                  :id, :fname, :lname, :team_name, :position do |player|
#   json.contract_id player player.player_contracts[0] :id
# end
