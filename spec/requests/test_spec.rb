require_relative '../../controllers/tests_controller'

RSpec.describe 'API test' do
  context 'GET /tests' do
    it 'returns a JSON response with all tests' do
      result = [{ test: 'Test 1' }, { test: 'Test 2' }]
      allow(TestRepository).to receive(:all).and_return(result)

      get '/tests'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(result.to_json) 
    end
  end
end
