# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shifts', type: :request do
  describe 'POST /workers/:worker_id/shifts' do
    let(:worker) { FactoryBot.create(:worker) }
    let(:end_time) { Time.zone.parse('2023-06-22 16:00:00') }
    let(:params) { { start_time: Time.zone.parse('2023-06-22 08:00:00'), end_time: end_time } }
    let(:request) { post "/workers/#{worker.id}/shifts", params: { shift: params } }

    context 'with valid params' do
      it 'creates a new shift' do
        expect { request }.to change(Shift, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(json_response[:id]).to eql(Shift.last.id)
      end
    end

    context 'with invalid params' do
      let(:end_time) { Time.current + 4.hours }

      it 'returns an error message' do
        request

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Shift must be 8 hours long')
      end
    end
  end
end
