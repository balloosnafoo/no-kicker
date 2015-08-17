if @roster_slots
  json.extract! @team, :id, :league_id, :manager_id, :name
  json.roster_slots do
    positions = ["qb", "rb", "wr", "te", "flex", "dst", "k", "bench"]
    positions.each do |pos|
      slots = @team.roster_slots.where(roster_slots: { position: pos })
      json.array! slots do |slot|
        json.extract! slot, :id, :position, :team_id
        if slot.player
          json.player do
            json.extract! slot.player, :fname, :lname, :position, :id, :team_name
          end
        end
      end
    end
  end
else
  json.extract! @team, :id, :league_id, :manager_id, :name
  json.players do
    json.array! @team.players do |player|
      json.extract! player, :fname, :lname, :position, :id, :team_name
    end
  end
end
