require 'rails_helper'

RSpec.describe 'Courses API' do
  let(:user) { create(:user) }
  # Initialize the test data
  let!(:school) { create(:school, created_by: user.id) }
  let!(:courses) { create_list(:course, 20, school_id: school.id) }
  let(:school_id) { school.id }
  let(:id) { courses.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /schools/:school_id/courses
  describe 'GET /schools/:school_id/courses' do
    before { get "/schools/#{school_id}/courses", params: {}, headers: headers }

    context 'when school exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all school courses' do
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

  # Test suite for GET /schools/:school_id/courses/:id
  describe 'GET /schools/:school_id/courses/:id' do
    before { get "/schools/#{school_id}/courses/#{id}", params: {}, headers: headers }

    context 'when school course exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the course' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when school course does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Course/)
      end
    end
  end

  # Test suite for PUT /schools/:school_id/courses
  describe 'POST /schools/:school_id/courses' do
    let(:valid_attributes) { { name: 'Full Stack Immersive', url: 'bootcamp.com/full_stack_immersive', description: 'Learn to code in 9 weeks.' }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/schools/#{school_id}/courses", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/schools/#{school_id}/courses", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /schools/:school_id/courses/:id
  describe 'PUT /schools/:school_id/courses/:id' do
    let(:valid_attributes) { { name: 'Full Stack Web Development Immersive' }.to_json }

    before do
      put "/schools/#{school_id}/courses/#{id}", params: valid_attributes, headers: headers
    end

    context 'when course exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the course' do
        updated_course = Course.find(id)
        expect(updated_course.name).to match(/Full Stack Web Development Immersive/)
      end
    end

    context 'when the course does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Course/)
      end
    end
  end

  # Test suite for DELETE /schools/:id
  describe 'DELETE /schools/:id' do
    before { delete "/schools/#{school_id}/courses/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
