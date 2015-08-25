class CreateRosterRules < ActiveRecord::Migration
  def change
    create_table :roster_rules do |t|
      t.integer :league_id, null: false
      t.integer :num_qb, null: false, default: 1
      t.integer :num_rb, null: false, default: 2
      t.integer :num_wr, null: false, default: 2
      t.integer :num_te, null: false, default: 1
      t.integer :num_flex, null: false, default: 1
      t.integer :num_dst, null: false, default: 0
      t.integer :num_k, null: false, default: 0
      t.integer :num_bench, null: false, default: 6

      t.timestamps null: false
    end
  end
end
