class AddBalanceToUsers < ActiveRecord::Migration[8.0]
  def change
     add_column :users, :balance, :decimal, precision: 30, scale: 10, default: 0
  end
end
