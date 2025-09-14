class Doer < ApplicationRecord
  belongs_to :user
  has_many :chore_trackers
end
