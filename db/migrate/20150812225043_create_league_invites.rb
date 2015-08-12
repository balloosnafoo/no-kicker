class CreateLeagueInvites < ActiveRecord::Migration
  def change
    create_table :league_invites do |t|
      t.integer :league_id, null: false
      t.string :username
      t.string :email

      t.timestamps null: false
    end
  end
end
