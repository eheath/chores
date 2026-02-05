class ChoreTracker < ApplicationRecord
  belongs_to :doer
  belongs_to :chore
  belongs_to :user

  validates :doer, presence: true
  validates :chore, presence: true
  validates :user, presence: true

  scope :completed, -> { where.not(completed_at: nil) }
  scope :pending, -> { where(completed_at: nil) }
  scope :notified, -> { where.not(notified_at: nil) }

  def complete!
    update!(completed_at: Time.current)
  end

  def notify!
    update!(notified_at: Time.current)
  end

  def completed?
    completed_at.present?
  end

  def notified?
    notified_at.present?
  end
end
