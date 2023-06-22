# frozen_string_literal: true

class Worker < ApplicationRecord
  has_many :shifts

  validates :name, presence: true
  validate :unique_shift_per_day

  private

  def unique_shift_per_day
    return unless shifts.exists?(created_at: Date.today.beginning_of_day..Date.today.end_of_day)

    errors.add(:base, 'Worker already has a shift on this day')
  end
end
