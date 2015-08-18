import nflgame as nfl

POSITIONS = [
    "qb",
    "wr",
    "rb",
    "te",
    "dst",
    "k"
]

def pull_players(pos):
    read_file = open(pos + "s.csv", "r")
    for i in range(6):
        f.readline()
    for line in read_file:
        data = line.strip().split(",")
        name, team = data[1], data[2]
    for i in range(1,16):


def get_player_object(name, pos):
    for p in nfl.find(name):
        if team == p.pos:
            player = p
    return player

def get_player_stats(player):

    team = player.team
    weeks = range(1, week)

    stats = []
    stats.append(HEADERS[player.position])

    for w in weeks:
        try:
            game = nfl.games(year, w, home=team, away=team)
            players = nfl.combine(game)
            player_game_stats = players.name(player.gsis_name)
            if not player_game_stats:
                player_game_stats = "DNP"
        except:
            player_game_stats = "BYE"
        stats.append(STAT_FUNCTIONS[player.position](player_game_stats))
        stats[-1].append(score_player(player_game_stats, player.position))

    return stats
    
