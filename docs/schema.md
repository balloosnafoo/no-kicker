# Schema Information

## leagues
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
commissioner_id | integer   | not null, foreign key (references users)
name            | string    | not null
rule_set_id     | integer   | not null

## league_memberships
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
league_id   | integer   | not null, foreign key (references leagues)
member_id   | integer   | not null, foreign key (references users)

## teams
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
owner_id    | integer   | not null, foreign key (references users)
league_id   | string    | not null, foreign key (references leagues)
name        | string    | not null

## players
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
team_id     | integer   | foreign_key (references teams)
fname       | string    | not null
lname       | string    | not null
position    | string    | not null
team_name   | string    | not null (refers to real life team)

## game_stats
column name   | data type | details
--------------|-----------|-----------------------
id            | integer   | not null, primary key
player_id     | integer   | not null, foreign key (references posts)
home_team     | string    | not null
away_team     | string    | not null
rush_yds      | integer   | not null
rush_tds      | integer   | not null
rush_attempts | integer   | not null
passing_yds   | integer   | not null
passing_tds   | integer   | not null
receiving_yds | integer   | not null
receiving_tds | integer   | not null
targets       | integer   | not null
receptions    | integer   | not null
interceptions | integer   | not null
fumbles       | integer   | not null

## users
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
email           | string    | not null, unique
password_digest | string    | not null
session_token   | string    | not null, unique
