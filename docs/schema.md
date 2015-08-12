# Schema Information

## leagues
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
commissioner_id | integer   | not null, foreign key
num_teams       | integer   | not null
num_divisions   | integer   | not null
name            | string    | not null
match_type      | string    | not null, default "h2h"
public          | boolean   | not null, default true
redraft         | boolean   | not null, default true

## score_rules
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
league_id       | integer   | not null, foreign key
rush_ppy        | integer   | not null, default 10
rec_ppy         | integer   | not null, default 10
rec_ppr         | integer   | not null, default 0
...             | ...       | ...

Note: due to the size of this table many values have been
excluded from the readme. Please see schema.rb for full info.
point values are represented as actual_points * 100 in order
to avoid using floats.

## roster_rules
column name  | data type | details
----- -------|-----------|-----------------------
id           | integer   | not null, primary key
num_rbs      | integer   | not null, default 2
num_wrs      | integer   | not null, default 2
num_tes      | integer   | not null, default 1
num_qbs      | integer   | not null, default 1
num_flex     | integer   | not null, default 1
num_dst      | integer   | not null, default 1
num_bench    | integer   | not null, default 6

## league_memberships
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
league_id   | integer   | not null, foreign key (references leagues)
member_id   | integer   | not null, foreign key (references users)

## team_memberships
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
team_id     | integer   | not null, foreign key (references teams)
player_id   | integer   | not null, foreign key (references players)

## teams
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
owner_id    | integer   | not null, foreign key (references users)
league_id   | string    | not null, foreign key (references leagues)
name        | string    | not null
wins        | integer   | not null
losses      | integer   | not null

## players
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
fname       | string    | not null
lname       | string    | not null
position    | string    | not null
team_name   | string    | not null (refers to real life team)

## game_stats
column name   | data type | details
--------------|-----------|-----------------------
id            | integer   | not null, primary key
player_id     | integer   | not null, foreign key (references players)
home_team     | string    | not null
away_team     | string    | not null
week          | integer   | not null
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

## starting_slot
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
player_id   | integer   | not null, foreign key (references players)
week        | integer   | not null
position    | string    | not null

## trade_offers
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
trader_id   | integer   | not null, foreign key (references players)
tradee_id   | integer   | not null, foreign key (references players)

## trade_items
column name    | data type | details
---------------|-----------|-----------------------
id             | integer   | not null, primary key
player_id      | integer   | not null, foreign key (references players)
owner_id       | integer   | not null, foreign key (references users)
trade_offer_id | integer   | not null, foreign key (references trade offers)

## matchup
column name    | data type | details
---------------|-----------|-----------------------
id             | integer   | not null, primary key
team_1_id      | integer   | not null, foreign key (references users)
team_2_id      | integer   | not null, foreign key (references users)
week           | integer   | not null

## users
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
email           | string    | not null, unique
username        | string    | not null, unique
password_digest | string    | not null
session_token   | string    | not null, unique
