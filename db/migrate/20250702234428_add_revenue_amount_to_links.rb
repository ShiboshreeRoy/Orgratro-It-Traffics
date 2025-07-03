class AddRevenueAmountToLinks < ActiveRecord::Migration[8.0]
  def change
    add_column :links, :revenue_amount, :decimal
  end
end
