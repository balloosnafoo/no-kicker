class CreateLeagueMemberships < ActiveRecord::Migration
  def change
    create_table :league_memberships do |t|
      t.integer :league_id, null: false
      t.integer :member_id, null: false

      t.timestamps null: false
    end

    add_index :league_memberships, [:league_id, :member_id], unique: :true
  end
end
