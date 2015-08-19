class CreateTradeItems < ActiveRecord::Migration
  def change
    create_table :trade_items do |t|
      t.integer :player_id, null: false
      t.integer :owner_id, null: false
      t.integer :trade_offer_id, null: false

      t.timestamps null: false
    end
  end
end
