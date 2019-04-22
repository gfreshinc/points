class CreateGfreshPointRule < ActiveRecord::Migration[5.2]
  def change
    create_table :gfresh_point_rules do |t|
      t.string :app_id
      t.string :event_name
      t.integer :point

      t.timestamps
    end
    add_index :gfresh_point_rules, :app_id


    create_table :gfresh_point_balances do |t|
      t.string :app_id
      t.string :user_id
      t.integer :point
      t.integer :balance
      t.timestamps
    end
    add_index :gfresh_point_balances, :app_id
    add_index :gfresh_point_balances, :user_id

  end
end
