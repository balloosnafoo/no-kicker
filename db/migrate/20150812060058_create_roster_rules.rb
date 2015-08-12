class CreateRosterRules < ActiveRecord::Migration
  def change
    create_table :roster_rules do |t|

      t.timestamps null: false
    end
  end
end
