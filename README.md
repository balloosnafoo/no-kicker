# No Kicker

[nokicker.co](no-kicker-link)

## Features

No kicker is a clone of the fantasy football app no kicker, and it includes
many of the functions necessary for a fantasy football app.

### Leagues

Users are allowed to create their own leagues and can specify some of the rules
of the league, such as how many teams there are and whether or not the league
is public.

Leagues are provided with default scoring and roster rules, and matchups are
generated so that teams play each other not more than twice during the season.
Matchups are automatically generated on the creation of the final team.

### Team Creation and Management

Players can create teams that are either public or have invited them. In the
current implementation, users can begin picking up players for their team
immediately, however the goal would be to lock player pick ups until the draft
has occurred once draft functionality is implemented.

Team lineups are managed on the team's show page, where each player's listing
has a dropdown menu that reflects the possible roster slots that a user can
allocate to that player. Additionally, players can be dropped from this page.

When adding players from the player index, the transaction occurs immediately
if the user's current team has an open roster spot. If this is not the case, then
they are directed to a page where they can choose which player to drop in order
to make space, making the add/drop in one step.

### Dynamic Player Searching

The players index can be dynamically searched by player name as well as filtered
by player position. In the future I intend to also make this index filterable
by whether or not they are already on a team in a given league.

### Trades

Users can offer trades to other users in their league, as well as responding
to those offered to them. If trades involve players who are then cut or given
in another trade, the trade offer is deleted from the database.

### Matchups

When the week is incremented, teams are scored based on the current starting
lineup and team wins and losses are calculated from these scored.

### League Message Board

Users can create and respond to threads in their league message boards.

[Implementation docs](implementation-link)

[no-kicker-link]: http://www.nokicker.co
[implementation-link]: ./docs/implementation_plan.md
