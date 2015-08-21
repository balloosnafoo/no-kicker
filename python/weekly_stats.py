import nflgame as nfl
write_file = open('python/weekly_stats.csv', 'w')

for i in range(1, 17):
    games = nfl.games(2014, week=i)
    players = nfl.combine(games)

    for player in players:
        if player.guess_position in ["RB", "WR", "TE", "QB"]:
            weekly_stats = [
                str(player.name),
                str(player.team),
                str(player.guess_position),
                str(i),
                str(player.rushing_att),
                str(player.rushing_tds),
                str(player.rushing_yds),
                str(player.fumbles_lost),
                str(player.passing_att),
                str(player.passing_int),
                str(player.passing_tds),
                str(player.passing_yds),
                str(player.receiving_rec),
                str(player.receiving_tar),
                str(player.receiving_tds),
                str(player.receiving_yds)
            ]

            write_file.write(",".join(weekly_stats) + "\n")

write_file.close()
