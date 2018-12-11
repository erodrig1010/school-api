require 'rails_helper'

RSpec.describe 'Tracks API' do
  let(:user) { create(:user) }
  # Initialize the test data
  let!(:school) { create(:school, created_by: user.id) }
  let!(:tracks) { create_list(:track, 20, school_id: school.id) }
  let(:school_id) { school.id }
  let(:id) { tracks.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /schools/:school_id/tracks
  describe 'GET /schools/:school_id/tracks' do
    before { get "/schools/#{school_id}/tracks", params: {}, headers: headers }

    context 'when school exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all school tracks' do
        expect(json.size).to eq(20)
      end
    end

    context 'when school does not exist' do
      let(:school_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find School/)
      end
    end
  end

  # Test suite for GET /schools/:school_id/tracks/:id
  describe 'GET /schools/:school_id/tracks/:id' do
    before { get "/schools/#{school_id}/tracks/#{id}", params: {}, headers: headers }

    context 'when school track exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the track' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when school track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for PUT /schools/:school_id/tracks
  describe 'POST /schools/:school_id/tracks' do
    let(:valid_attributes) { { name: 'IT Support', url: 'bootcamp.com/itsupport' }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/schools/#{school_id}/tracks", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/schools/#{school_id}/tracks", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /schools/:school_id/tracks/:id
  describe 'PUT /schools/:school_id/tracks/:id' do
    let(:valid_attributes) { { name: 'IT Support Specialist' }.to_json }

    before do
      put "/schools/#{school_id}/tracks/#{id}", params: valid_attributes, headers: headers
    end

    context 'when track exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the track' do
        updated_track = Track.find(id)
        expect(updated_track.name).to match(/IT Support Specialist/)
      end
    end

    context 'when the track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for DELETE /schools/:id
  describe 'DELETE /schools/:id' do
    before { delete "/schools/#{school_id}/tracks/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
