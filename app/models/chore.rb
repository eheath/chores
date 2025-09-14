class Chore < ApplicationRecord
  belongs_to :user
  has_many :doers
  validates :title, presence: true
end
