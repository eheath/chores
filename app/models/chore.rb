class Chore < ApplicationRecord
  belongs_to :user
  has_many :doers
  validates :title, presence: true
  serialize :days, coder: JSON
  before_save :set_days

  def days_of_week
    %w[ Su Mo Tu We Th Fr Sa ]
  end

  def set_days
    self.days = [] if self.days.nil?
  end
end
