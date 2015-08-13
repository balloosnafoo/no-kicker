import nflgame as nfl

def import_fpros_overall():
    f = open('data/fpros_overall.csv', 'r')
    for i in range(6):
        f.readline()
    players = []
    for line in f:
        player_info = line.strip().split(",")
        rank, name, team, bye, _1, _2, _3, _4, _5 = player_info
        fname, lname = name.split(" ")
        
        players.append(
            name: {
                "team": team,
                "bye": bye
            }
        )
