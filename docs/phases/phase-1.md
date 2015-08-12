# Phase 1: User Authentication, league creation (~1 Day)

## Rails
### Models
* User
* Session
* League
* Team
* LeagueMemberships
* ScoreRule

### Controllers
* UsersController (create, new)
* SessionsController (create, new, destroy)
* Api::LeaguesController (create, new, show)
* Api::TeamsController (create, new, show)
* Api::LeagueMembershipsController (create, destroy)
* Api::ScoreRulesController (edit)

### Views
* users/new.html.erb
* session/new.html.erb

## Backbone

### Collections
* Leagues
* Teams

### Models
* League
* Team

### Views
* Leagues (new, index)
* Teams (new, index)
