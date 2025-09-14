class CreateChores < ActiveRecord::Migration[8.0]
  def change
    create_table :chores do |t|
      t.references :user
      t.string :title, null: false
      t.string :notes, null: true
      t.integer :points, null: false
      t.timestamps
    end
  end
end
