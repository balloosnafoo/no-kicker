class CreateRosterSlots < ActiveRecord::Migration
  def change
    create_table :roster_slots do |t|
      t.integer :player_id
      t.integer :team_id, null: false
      t.string :position, null: false
      t.integer :order, null: false

      t.timestamps null: false
    end
  end
end
