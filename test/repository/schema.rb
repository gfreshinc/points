ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :email

    t.timestamps
  end

  create_table :gfresh_point_rules do |t|
    t.string  :app_id
    t.string  :event_name
    t.integer :point

    t.timestamps
  end
  add_index :gfresh_point_rules, :app_id

  create_table :gfresh_point_balances do |t|
    t.string  :app_id
    t.string  :user_id
    t.integer :point
    t.integer :balance
    t.string  :comment
    t.timestamps
  end
  add_index :gfresh_point_balances, :app_id
  add_index :gfresh_point_balances, :user_id

end
