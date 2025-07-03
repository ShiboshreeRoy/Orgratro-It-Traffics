class AddVisitCountToLinks < ActiveRecord::Migration[8.0]
  def change
    add_column :links, :visit_count, :integer
  end
end
