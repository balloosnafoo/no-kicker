class CreateTradeOffers < ActiveRecord::Migration
  def change
    create_table :trade_offers do |t|
      t.integer :league_id, null: false
      t.integer :trader_id, null: false
      t.integer :tradee_id, null: false
      t.boolean :pending, null: false, default: true

      t.timestamps null: false
    end
  end
end
