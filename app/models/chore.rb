class Chore < ApplicationRecord
  belongs_to :user
  has_many :chore_trackers, dependent: :destroy
  has_many :doers, through: :chore_trackers
  validates :title, presence: true
  validates :points, presence: true
  serialize :days, coder: JSON
  before_save :set_days

  scope :active, -> { where(is_deleted: false) }
  scope :deleted, -> { where(is_deleted: true) }

  def days_of_week
    %w[ Su Mo Tu We Th Fr Sa ]
  end

  def set_days
    self.days = [] if days.nil?
  end
end
