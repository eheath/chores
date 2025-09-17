class AddDaysToChores < ActiveRecord::Migration[8.0]
  def change
    add_column :chores, :days, :string
  end
end
