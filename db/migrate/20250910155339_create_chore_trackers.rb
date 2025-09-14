class CreateChoreTrackers < ActiveRecord::Migration[8.0]
  def change
    create_table :chore_trackers do |t|
      t.references :doer
      t.references :user
      t.references :chore
      t.timestamp :notified_at
      t.timestamp :completed_at
      t.timestamps
    end
  end
end
