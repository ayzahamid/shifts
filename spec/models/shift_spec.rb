# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe 'associations' do
    it { should belong_to(:worker) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it 'validates shift duration' do
      shift = build(:shift, start_time: Time.current, end_time: Time.current + 4.hours)
      expect(shift).to_not be_valid
      expect(shift.errors[:base]).to include('Shift must be 8 hours long')
    end
  end

  describe '#validate_shift_range' do
    let(:worker) { create(:worker) }
    let(:start_time) { Time.zone.parse('2023-06-22 08:00:00') }
    let(:end_time) { Time.zone.parse('2023-06-22 16:00:00') }
    let(:shift) do
      build(
        :shift,
        worker: worker,
        start_time: start_time,
        end_time: end_time
      )
    end

    context 'when start_time and end_time fall within valid ranges' do
      it 'is a valid shift' do
        expect(shift).to be_valid
      end
    end

    context 'when start_time and end_time fall outside valid ranges' do
      let(:start_time) { Time.zone.parse('2023-06-22 05:00:00') }
      let(:end_time) { Time.zone.parse('2023-06-22 12:00:00') }

      it 'is an invalid shift' do
        expect(shift).not_to be_valid
        expect(shift.errors[:base]).to include('Shift must be within the 24-hour timetable (0-8, 8-16, 16-24)')
      end
    end
  end
end
