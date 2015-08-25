## Minimum Viable Product
No Kicker is a clone of Flea Flicker built on Rails on Backbone. Users can:

- [X] Create accounts and login
- [X] Create new leagues
- [X] View teams in their own league
- [X] Browse leagues
- [X] Create teams in leagues to which they have access
- [X] Add and drop players
- [X] See general player stats
- [X] Search for players by name/position
- [X] Determine starting lineups
- [X] Create and respond to trade offers
- [X] Create and comment on threads in their leagues

## Design Docs
* [View Wireframes][views]
* [DB schema][schema]

[views]: ../docs/views.md
[schema]: ../docs/schema.md

## Implementation Timeline

### Phase 1: User Authentication, league creation (~1 Days)
I will implement a user authentication system based on the practices taught at
App Academy. By the end of this phase users will be able to create accounts,
log in, and create leagues. The app will be pushed to Heroku in order to begin
ensuring functionality early on and throughout development. League creation
will offer reasonable defaults for league rules.

[Details][phase-one]

### Phase 2: Viewing/Joining Leagues and creating teams (~2 Days)
During this phase I will implement viewing functionality so that users can
see all of their leagues, and the names of the teams in the league in
backbone views. Data will be served by api controllers in JSON, which will
be made during this phase. This requires creation of league invitations and
validations to check that the league is public or the user is invited.

[Details][phase-two]

### Phase 3: Viewing the available player pool, add, drop players (~2 Days)
This will allow users to view all of the players that are not currently on a
team in their league. This pool will be searchable and sortable by a number
of relevant criteria. Users can drop players from their teams as well as adding
players from the pool of unowned players. These can be done in a single
step, which is important.

[Details][phase-three]

### Phase 4: Setting Lineups (~2 Days)
Functionality will be implemented so that users can set their lineups. These
are subject to restrictions based on league rules as well as timelines. For
instance, users cannot move players into slots that are designated for other
positions. They also are not allowed to move players into or out of the lineup
after games have started.

[Details][phase-four]

### Phase 5: Creating and responding to trade offers (~1.5 Days)
This will require a new trade backbone view, which should list all of the
players on the user's team along with those on the trading partner's team.
There will also be an index view in which a user can look at the open trades
relevant to him and accept, reject or cancel them (if they were offered to
or by him respectively).

[Details][phase-five]

### Phase 6: Creating threads and commenting (~1 Day)
This will require creating Thread and Comment objects as well as backbone views
for each of those. Each league should have a thread index page and each thread
should have a show page where all of the comments are listed and new comments
can be created.

[Details][phase-six]

## Bonus Features

- [ ] Add players to watch lists
- [ ] Users can set up warning systems, so that they are notified of dramatic
      changes in ownership of players that they are watching.
- [ ] Users can set up and enter drafts.
- [ ] Trades are subject to review by either commissioner, league voting, or
      trade arbiters.
- [ ] Commissioners can appoint trade arbiters.
- [ ] Adds requests made after games have started go through the waiver wire
- [ ] User show page shows user stats (% overall wins)

[phase-one]: ../docs/phases/phase-1.md
[phase-two]: ../docs/phases/phase-2.md
[phase-three]: ../docs/phases/phase-3.md
[phase-four]: ../docs/phases/phase-4.md
[phase-five]: ../docs/phases/phase-5.md
[phase-six]: ../docs/phases/phase-6.md
