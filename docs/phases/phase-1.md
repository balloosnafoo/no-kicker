# Phase 1: User Authentication, league creation (~1 Day)

## Rails
### Models
* User

### Controllers
* UsersController (create, new)
* SessionsController (create, new, destroy)
* Api::LeaguesController (create, new, show)
* Api::TeamsController (create, new, show)
* Api::LeagueMemberships (create, destroy)

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
