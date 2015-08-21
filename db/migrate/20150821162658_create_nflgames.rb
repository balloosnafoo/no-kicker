class CreateNflgames < ActiveRecord::Migration
  def change
    create_table :nflgames do |t|
      t.string :home_team, null: false
      t.string :away_team, null: false
      t.integer :home_score, null: false
      t.integer :away_score, null: false
      t.integer :week, null: false

      t.timestamps null: false
    end
  end
end
