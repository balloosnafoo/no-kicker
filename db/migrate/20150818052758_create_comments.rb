class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :author, null: false
      t.integer :thread_id
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
