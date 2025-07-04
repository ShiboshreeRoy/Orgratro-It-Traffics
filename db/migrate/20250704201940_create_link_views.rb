class CreateLinkViews < ActiveRecord::Migration[8.0]
  def change
    create_table :link_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :link, null: false, foreign_key: true
      t.datetime :viewed_at

      t.timestamps
    end
  end
end
