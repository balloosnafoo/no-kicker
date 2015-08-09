# No Kicker

\[link goes here\]

## Minimum Viable Product
No Kicker is a clone of Flea Flicker built on Rails on Backbone. Users can:

- [ ] Create accounts and login
- [ ] Create new leagues
- [ ] Create teams in leagues to which they have access
- [ ] View teams in their own league
- [ ] Create and respond to trade offers
- [ ] Add and drop players
- [ ] Create and comment on threads in their leagues
- [ ] See player stats
- [ ] Search for players by name/position/points
- [ ] Add players to watch lists
- [ ] Determine starting lineups

## Design Docs
* [View Wireframes][views]
* [DB schema][schema]

[views]: ./docs/views.md
[schema]: ./docs/schema.md

## Implementation Timeline

### Phase 1: User Authentication, league creation (~1 Day)
I will implement a user authentication system based on the practices taught at
App Academy. By the end of this phase users will be able to create accounts,
log in, and create or join leagues that are open to them. The app will be
pushed to Heroku in order to begin ensuring functionality early on and
throughout development.

[Details][phase-one]

### Phase 2: Viewing Leagues and teams (~2 Days)
During this phase I will implement viewing functionality so that users can
see all of their leagues and teams, as well as other teams in the league in
backbone views. Data will be served by api controllers in JSON.

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

### Phase 5: Creating and responding to trade offers

[Details][phase-five]

## Bonus Features

- [ ] Users can set up warning systems, so that they are notified of dramatic
      changes in ownership of players that they are watching.
- [ ] Users can set up and enter drafts.
- [ ] Commissioners can appoint trade arbiters.

[phase-one]: ./docs/phases/phase-1.md
[phase-two]: ./docs/phases/phase-2.md
[phase-three]: ./docs/phases/phase-3.md
[phase-four]: ./docs/phases/phase-4.md
[phase-five]: ./docs/phases/phase-5.md
