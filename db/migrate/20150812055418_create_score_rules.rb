class CreateScoreRules < ActiveRecord::Migration
  def change
    create_table :score_rules do |t|
      t.integer :league_id, null: false

      # Rushing points
      t.integer :rushing_yds, null: false, default: 10
      t.integer :rushing_tds, null: false, default: 800

      # Recieving points
      t.integer :receiving_yds, null: false, default: 10
      t.integer :receiving_tds, null: false, default: 800
      t.integer :receiving_rec, null: false, default: 0

      # Passing points
      t.integer :passing_yds, null: false, default: 5
      t.integer :passing_tds, null: false, default: 600
      t.integer :passing_int, null: false, default: -200

      # General Offense
      t.integer :fumbles_lost, null: false, default: -200

      # Defense
      t.integer :sack, null: false, default: 100
      t.integer :def_int, null: false, default: 200
      t.integer :fumble_rec, null: false, default: 200
      t.integer :def_td, null: false, default: 600
      t.integer :safety, null: false, default: 200
      t.integer :block_kick, null: false, default: 200
      t.integer :ret_td, null: false, default: 600
      t.integer :fourth_stops, null: false, default: 200

      # Defense Points Against
      t.integer :pts_allow1, null: false, default: 1000
      t.integer :pts_allow2, null: false, default: 700
      t.integer :pts_allow3, null: false, default: 400
      t.integer :pts_allow4, null: false, default: 100
      t.integer :pts_allow5, null: false, default: 0
      t.integer :pts_allow6, null: false, default: 0
      t.integer :pts_allow7, null: false, default: -300

      t.timestamps null: false
    end
  end
end
