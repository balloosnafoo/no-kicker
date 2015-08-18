class CreateWeeklyStats < ActiveRecord::Migration
  def change
    create_table :weekly_stats do |t|
      t.integer :player_id, null: false

      t.integer :rushing_att, default: 0
      t.integer :rushing_tds, default: 0
      t.integer :rushing_yds, default: 0
      t.integer :fumbles_lost, default: 0
      t.integer :passing_att, default: 0
      t.integer :passing_int, default: 0
      t.integer :passing_tds, default: 0
      t.integer :passing_yds, default: 0
      t.integer :receiving_rec, default: 0
      t.integer :receiving_tar, default: 0
      t.integer :receiving_tds, default: 0
      t.integer :receiving_yds, default: 0

      t.timestamps null: false
    end
  end
end
