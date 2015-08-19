class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :author_id, null: false
      t.integer :message_id, null: false
      t.integer :parent_id
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
