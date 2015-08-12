class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :fname
      t.string :lname
      t.string :position, null: false
      t.string :team_name, null: false

      t.timestamps null: false
    end
  end
end
