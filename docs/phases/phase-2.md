# Phase 2: Viewing Leagues and teams (~2 Days)

## Rails
### Models
* League#generate_schedule

### Controllers

### Views
* leagues/show.json.jbuilder

## Backbone
### Models
* League (parses nested `teams` association)
* Team

### Collections
* Leagues
* Teams

### Views
* LeagueForm
* LeagueShow (composite view, contains TeamsIndex subview)
* TeamsIndex
* TeamsShow

## Gems/Libraries
