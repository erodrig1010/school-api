require 'rails_helper'

RSpec.describe 'Schools API', type: :request do
  # add todos owner
  let(:user) { create(:user) }
  # initialize test data
  let!(:schools) { create_list(:school, 10, created_by: user.id) }
  let(:school_id) { schools.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /schools
  describe 'GET /schools' do
    # make HTTP get request before each example
    before { get '/schools', params: {}, headers: headers }

    it 'returns schools' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /schools/:id
  describe 'GET /schools/:id' do
    before { get "/schools/#{school_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the school' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(school_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:school_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find School with 'id'=#{school_id}/)
      end
    end
  end

  # Test suite for POST /schools
  describe 'POST /schools' do
    # valid payload
    let(:valid_attributes) do
        { name: 'IronHack', created_by: user.id.to_s, source_url: 'www.ironhack.com' }.to_json
    end

    context 'when the request is valid' do
      before { post '/schools', params: valid_attributes, headers: headers }

      it 'creates a school' do
        expect(json['name']).to eq('IronHack')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: nil }.to_json }
      before { post '/schools', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(/Validation failed: Name can't be blank, Source url can't be blank/)
      end
    end
  end

  # Test suite for PUT /schools/:id
  describe 'PUT /schools/:id' do
    let(:valid_attributes) { { name: 'Put School' }.to_json }

    context 'when the record exists' do
      before { put "/schools/#{school_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /schools/:id
  describe 'DELETE /schools/:id' do
    before { delete "/schools/#{school_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
