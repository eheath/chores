class ChoreTracker < ApplicationRecord
  belongs_to :doer
  belongs_to :chore
  belongs_to :user
end
