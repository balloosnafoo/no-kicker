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


User.create(username: "baloo", password: "password", email: "baloo@butts.com")
League.create(
  commissioner_id: 1,
  num_teams: 1,
  num_divisions: 1,
  public: true,
  redraft: true,
  match_type: "h2h",
  name: "Doge Leauge"
)
Team.create(
  league_id: 1,
  division: 1,
  manager_id: 1,
  name: "Straight Cache Homey"
)
11.times do |i|
  User.create(
    username: Faker::Internet.user_name,
    password: "password",
    email: Faker::Internet.free_email
  )

  User.find(i + 2).teams.new(
    league_id: 1,
    division: 1,
    manager_id: i + 2,
    name: Faker::Book.title
  )
end
