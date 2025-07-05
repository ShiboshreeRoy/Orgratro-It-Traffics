class CreateInstructionClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :instruction_clicks do |t|
      t.references :instruction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :clicked_at

      t.timestamps
    end
  end
end
