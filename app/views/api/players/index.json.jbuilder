json.array! @players do |player|
  json.extract! player, :id, :fname, :lname, :position, :team_name
  contract = @league.player_contract(player.id)
  if contract
    json.contract_id contract, :id
  end
end
