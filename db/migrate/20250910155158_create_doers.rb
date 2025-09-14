class CreateDoers < ActiveRecord::Migration[8.0]
  def change
    create_table :doers do |t|
      t.references :user
      t.string :name, null: false
      t.string :phone, null: false
      t.timestamps
    end
  end
end
