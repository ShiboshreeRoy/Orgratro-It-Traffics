class AddValueToLinks < ActiveRecord::Migration[8.0]
  def change
    add_column :links, :value, :decimal, precision: 20, scale: 10, default: 0
  end
end
