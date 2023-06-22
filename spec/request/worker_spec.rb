# frozen_string_literal: true

# spec/requests/workers_controller_spec.rb
require 'rails_helper'

RSpec.describe WorkersController, type: :request do
  let(:worker) { create(:worker) }
  let(:name) { 'John Doe' }
  let(:params) { { worker: { name: name } } }

  describe 'GET /workers' do
    before do
      create_list(:worker, 3)
    end

    it 'returns a list of workers' do
      get '/workers'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eql(3)
    end
  end

  describe 'GET /workers/:id' do
    it 'returns the worker' do
      get "/workers/#{worker.id}"

      expect(response).to have_http_status(:ok)
      expect(json_response[:id]).to be(worker.id)
    end
  end

  describe 'POST /workers' do
    context 'with valid params' do
      it 'creates a new worker' do
        expect do
          post '/workers', params: params
        end.to change(Worker, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(json_response[:id]).to be(Worker.last.id)
      end
    end

    context 'with invalid params' do
      let(:name) { '' }

      it 'returns an error message' do
        post '/workers', params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include("Name can't be blank")
      end
    end
  end

  describe 'PUT /workers/:id' do
    context 'with valid params' do
      let(:name) { 'Updated Name' }

      it 'updates the worker' do
        put "/workers/#{worker.id}", params: params

        expect(response).to have_http_status(:ok)
        expect(json_response[:id]).to be(worker.id)
        expect(worker.reload.name).to eq('Updated Name')
      end
    end
  end

  describe 'DELETE /workers/:id' do
    it 'deletes the worker' do
      delete "/workers/#{worker.id}"

      expect(response).to have_http_status(:no_content)
    end
  end
end
