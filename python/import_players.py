import nflgame as nfl

games = nfl.games(2014)
players = nfl.combine(games)

write_file = open('qbs.csv', 'w')

PLAYER_FILTERS = [
    players.passing,
    players.rushing,
    players.receiving,
]

for player_filter in PLAYER_FILTERS:
    for player in player_filter():
        stats = [
            player.name,
            player.team,
            player.guess_position
        ]
        write_file.write(",".join(stats) + "\n")

write_file.close()
