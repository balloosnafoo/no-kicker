class CreateRosterRules < ActiveRecord::Migration
  def change
    create_table :roster_rules do |t|
      t.integer :league_id, null: false
      t.integer :num_qbs, null: false, default: 1
      t.integer :num_rbs, null: false, default: 2
      t.integer :num_wrs, null: false, default: 2
      t.integer :num_tes, null: false, default: 1
      t.integer :num_flex, null: false, default: 1
      t.integer :num_dst, null: false, default: 1
      t.integer :num_k, null: false, default: 0
      t.integer :num_bench, null: false, default: 6

      t.timestamps null: false
    end
  end
end
