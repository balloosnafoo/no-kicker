# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SAMPLE_TEAM_NAMES = File.readlines("db/sample_team_names.txt")
SAMPLE_LEAGUE_NAMES = File.readlines("db/sample_league_names.txt")

File.foreach("./python/nfl_schedule.csv") do |game|
  home_team, away_team, home_score, away_score, week = game.chomp.split(",")
  Nflgame.create(
    home_team: home_team,
    away_team: away_team,
    home_score: home_score,
    away_score: away_score,
    week: week
  )
end

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
      player_id: player.id,
      week: week
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

120.times do |i|
  t = Team.find(i + 1)
  t.league.generate_roster_slots(t)
end

League.all.each { |league| league.generate_matchups }

10.times do |league_num|
  league = League.find(league_num + 1)
  team_ids = league.teams.pluck(:id).shuffle
  roster_rule = league.roster_rule
  ["QB", "RB", "WR", "TE"].each do |pos|
    roster_rule.send("num_#{pos.downcase}").times do |n|
      team_ids.each do |team_id|
        player = Player.first_unsigned_at_pos(pos, league_num + 1)
        team = Team.find(team_id)
        team.player_contracts.create(
          player_id: player.id,
          league_id: league_num + 1
        )
        team.assign_or_create_roster_slot(player)
      end
    end
  end
end

# Player.select("player_contracts.*, players.*").joins("LEFT OUTER JOIN player_contracts ON players.id = player_contracts.player_id").includes(:weekly_stats).where(player_contracts: {player_id: nil}).find_by(position: "RB")

Message.create(
  author_id: 1,
  league_id: 1,
  title: "Hey guys, welcome to the league",
  body: "If anyone has any question let me know. I'm looking forward to beating one of you in the championship this year"
)

Comment.create(
  author_id: 2,
  message_id: 1,
  body: "Haha yeah right man, there's no way you even make it to the playoffs... have you seen your team?"
)

Comment.create(
  author_id: 5,
  message_id: 1,
  body: "What did you even finish at last year"
)

Comment.create(
  author_id: 1,
  message_id: 1,
  body: "Hey now... how could I have foreseen those injuries? This year is my year"
)

Message.create(
  author_id: 2,
  league_id: 1,
  title: "Hey if anyone's looking for some help at RB hit me up",
  body: "I could use some improvement at WR and nobody's helping my team by sitting on the bench"
)

Comment.create(
  author_id: 3,
  message_id: 2,
  body: "I might be able to help. Are you going to be at Jay's tomorrow night"
)

Comment.create(
  author_id: 2,
  message_id: 2,
  body: "Yeah I think so, talk there?"
)

Comment.create(
  author_id: 3,
  message_id: 2,
  body: "Sounds good."
)

Week.create
Week.to_next_week!
Week.to_next_week!
Week.to_next_week!
