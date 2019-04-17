class CreateGfreshPointRule < ActiveRecord::Migration
  def change
    create_table :gfresh_point_rules do |t|
      t.string :app_id
      t.string :event_name
      t.integer :point

      t.timestamps
    end
    add_index :gfresh_point_rules, :app_id
  end
end
