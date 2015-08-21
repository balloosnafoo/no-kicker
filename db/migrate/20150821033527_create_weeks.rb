class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :current_week, null: false, default: 0
      
      t.timestamps null: false
    end
  end
end
