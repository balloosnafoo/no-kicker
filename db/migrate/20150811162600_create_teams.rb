class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :league_id, null: false
      t.integer :division, null: false
      t.integer :manager_id
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
