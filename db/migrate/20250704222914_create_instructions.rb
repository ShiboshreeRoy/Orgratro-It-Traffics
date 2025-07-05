class CreateInstructions < ActiveRecord::Migration[8.0]
  def change
    create_table :instructions do |t|
      t.string :title
      t.text :body
      t.string :link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
