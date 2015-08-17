class CreateRosterSlots < ActiveRecord::Migration
  def change
    create_table :roster_slots do |t|
      t.integer :player_id
      t.string :position
      t.integer :order

      t.timestamps null: false
    end
  end
end
