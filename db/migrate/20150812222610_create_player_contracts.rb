class CreatePlayerContracts < ActiveRecord::Migration
  def change
    create_table :player_contracts do |t|
      t.integer :team_id, null: false
      t.integer :player_id, null: false
      t.integer :league_id, null: false

      t.timestamps null: false
    end

    add_index :player_contracts, [:team_id, :player_id], unique: :true
  end
end
