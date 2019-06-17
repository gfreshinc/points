class CreateGfreshPointRule < ActiveRecord::Migration[5.2]
  def change
    create_table :gfresh_point_rules do |t|
      t.string  :app_id
      t.string  :event_name
      t.integer :point
      t.string  :name

      t.timestamps
    end
    add_index :gfresh_point_rules, [:app_id, :event_name], unique: true

    create_table :gfresh_point_balances do |t|
      t.string  :app_id
      t.string  :user_id
      t.integer :point
      t.integer :balance
      t.string  :event_name
      t.string  :origin_id
      t.json  :comment
      t.timestamps
    end
    add_index :gfresh_point_balances, :app_id
    add_index :gfresh_point_balances, :user_id
  end
end
