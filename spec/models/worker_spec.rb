# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe 'associations' do
    it { should have_many(:shifts) }
  end

  describe 'validations' do
    let(:worker) { create(:worker) }
    it 'validates unique shift per day' do
      create(:shift, worker: worker)
      shift = create(:shift, worker: worker)

      expect(shift.worker).to_not be_valid
      expect(shift.worker.errors.full_messages).to include('Worker already has a shift on this day')
    end
  end
end
