class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.integer :commissioner_id
      t.integer :num_teams, null: false
      t.integer :num_divisions, null: false

      t.boolean :public, null: false, default: true
      t.boolean :redraft, null: false, default: true

      t.string :match_type, null: false, default: :h2h
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
