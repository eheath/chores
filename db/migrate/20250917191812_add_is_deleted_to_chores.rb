class AddIsDeletedToChores < ActiveRecord::Migration[8.0]
  def change
    add_column :chores, :is_deleted, :boolean
  end
end
