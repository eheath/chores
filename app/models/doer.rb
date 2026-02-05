class Doer < ApplicationRecord
  belongs_to :user
  has_many :chore_trackers, dependent: :destroy
  has_many :chores, through: :chore_trackers

  validates :name, presence: true
  validates :phone, presence: true

  scope :active, -> { where(is_deleted: false) }
  scope :deleted, -> { where(is_deleted: true) }
end
