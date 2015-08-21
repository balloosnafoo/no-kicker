import nflgame as nfl

write_file = open("python/nfl_schedule.csv", "w")

for week in range(1, 17):
    games = nfl.games(2014, week=week)
    for g in games:
        info = [
            g.home,
            g.away,
            str(g.score_away),
            str(g.score_home),
            str(week)
        ]
        write_file.write(",".join(info) + "\n")

write_file.close()
