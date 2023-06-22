# frozen_string_literal: true

class Shift < ApplicationRecord
  belongs_to :worker

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validate_shift_duration
  validate :validate_shift_range

  private

  def validate_shift_duration
    return if start_time.blank? || end_time.blank?

    duration = (end_time - start_time) / 3600

    return if duration.to_i == 8

    errors.add(:base, 'Shift must be 8 hours long')
  end

  def validate_shift_range
    return if start_time.blank? || end_time.blank?

    start_hour = start_time.hour
    end_hour = end_time.hour

    valid_ranges = [[0, 8], [8, 16], [16, 24]]

    return if valid_ranges.any? { |range| start_hour >= range[0] && end_hour <= range[1] }

    errors.add(:base, 'Shift must be within the 24-hour timetable (0-8, 8-16, 16-24)')
  end
end
