class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :team_1_id, null: false
      t.integer :team_2_id, null: false
      t.integer :team_1_score, default: 0
      t.integer :team_2_score, default: 0
      t.integer :league_id, null: false
      t.integer :week, null: false

      t.timestamps null: false
    end
  end
end
