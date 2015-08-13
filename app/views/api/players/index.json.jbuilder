json.array! @players do |player|
  json.extract! player, :id, :fname, :lname, :position, :team_name
  if @league_specific && player.contract_id
    json.contract do
      json.id player.contract_id
      json.contract_owner_id player.contract_owner_id
    end
  end
end
