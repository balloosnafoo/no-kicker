class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :author_id, null: false
      t.integer :league_id, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
