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
end
