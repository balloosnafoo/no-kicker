# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SAMPLE_TEAM_NAMES = File.readlines("db/sample_team_names.txt")
SAMPLE_LEAGUE_NAMES = File.readlines("db/sample_league_names.txt")

names = {}
File.foreach("./python/players.csv") do |line|
  name, team, pos = line.chomp.split(",")
  pos = "RB" if pos == "FB"
  match = name.match(/.(?<lname>[A-Z].*)/)
  lname = match[:lname] if match
  unless names[name] || !["WR", "QB", "RB", "TE"].include?(pos)
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

File.foreach("./python/weekly_stats.csv") do |line|
  line = line.split(",")
  name = line[0]
  match = name.match(/.(?<lname>[A-Z].*)/)
  lname = match[:lname] if match
  fname = name[0]
  team = line[1]
  pos = line[2]
  week = line[3]
  rushing_att = line[4]
  rushing_tds = line[5]
  rushing_yds = line[6]
  fumbles_lost = line[7]
  passing_att = line[8]
  passing_int = line[9]
  passing_tds = line[10]
  passing_yds = line[11]
  receiving_rec = line[12]
  receiving_tar = line[13]
  receiving_tds = line[14]
  receiving_yds = line[15]
  player = Player.find_by_fname_and_lname_and_position(fname, lname, pos)
  if player
    player.weekly_stats.create(
      rushing_att: rushing_att,
      rushing_tds: rushing_tds,
      rushing_yds: rushing_yds,
      fumbles_lost: fumbles_lost,
      passing_att: passing_att,
      passing_int: passing_int,
      passing_tds: passing_tds,
      passing_yds: passing_yds,
      receiving_rec: receiving_rec,
      receiving_tar: receiving_tar,
      receiving_tds: receiving_tds,
      receiving_yds: receiving_yds,
      player_id: player.id
    )
  end
end


User.create(username: "baloo", password: "password", email: "baloo@gmail.com")
10.times do |league_num| # For later when I want to generate a bunch of leagues.
  league = League.create(
    commissioner_id: 1,
    num_teams: 12,
    num_divisions: 1,
    public: true,
    redraft: true,
    match_type: "h2h",
    name: SAMPLE_LEAGUE_NAMES.sample.chomp
  )
  league.score_rule = ScoreRule.new
  league.roster_rule = RosterRule.new
  Team.create(
    league_id: 1 + league_num,
    division: 1,
    manager_id: 1,
    name: SAMPLE_TEAM_NAMES.sample.chomp
  )
  11.times do |i|
    User.create(
      username: Faker::Internet.user_name,
      password: "password",
      email: Faker::Internet.free_email
    )

    User.find(i + 2).teams.create(
      league_id: 1 + league_num,
      division: 1,
      manager_id: i + 2,
      name: SAMPLE_TEAM_NAMES.sample.chomp
    )
  end
end

120.times do |i| # This is hard coded, because I know how many times baloo's team repeats
  t = Team.find(i + 1)
  t.league.generate_roster_slots(t)
end

League.first.generate_matchups
