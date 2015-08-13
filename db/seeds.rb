# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = {}
File.foreach("./python/players.csv") do |line|
  name, team, pos = line.chomp.split(",")
  match = name.match(/.+(?<lname>[A-Z].*)/)
  lname = match[:lname] if match
  unless names[name]
    if lname && team && pos
      Player.create!({
        fname: name[0],
        lname: lname,
        team_name: team,
        position: pos
      })
      names[name] = true
    end
  end
end

User.create(username: "Baloo", password: "password", email: "baloo@butts.com")
