class AddIsDeleteds < ActiveRecord::Migration[8.0]
  def change
    add_column :chores, :is_deleted, :boolean, default: false
    add_column :chores, :is_active, :boolean, default: true
    add_column :doers, :is_deleted, :boolean, default: false
    add_column :doers, :is_active, :boolean, default: true
  end
end
