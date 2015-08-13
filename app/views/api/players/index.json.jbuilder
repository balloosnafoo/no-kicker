json.array! @players do |player|
  json.extract! player, :id, :fname, :lname, :position, :team_name
  contract = @league.player_contracts.where(id: player.id)[0]
  if contract
    json.contract contract, :id
  end
  contract = nil
end
