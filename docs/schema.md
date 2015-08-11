# Schema Information

## leagues
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
name            | string    | not null
rule_set_id     | integer   | not null

## commissionerships
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
commissioner_id | integer   | not null, foreign key (references users)
league_id       | integer   | not null, foreign key (references leagues)

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
trade_offer_id | integer   | not null, foreign key (references trade offers)

## users
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
email           | string    | not null, unique
username        | string    | not null, unique
password_digest | string    | not null
session_token   | string    | not null, unique
