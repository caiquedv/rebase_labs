require_relative '../../../controllers/tests_controller'

RSpec.describe 'API test' do
  context 'GET /tests' do
    it 'returns a JSON response with all tests' do
      allow(DatabaseConfig).to receive(:test_setup)
      allow(TestRepository).to receive(:all).and_return([{ teste: 'Teste 1' }, { teste: 'Teste 2' }])

      get '/tests'

      expect(DatabaseConfig).to have_received(:test_setup)
      expect(JSON.parse(last_response.body)).to eq([{ 'teste' => 'Teste 1' }, { 'teste' => 'Teste 2' }])
      expect(last_response.status).to eq(200)
    end
  end
end 
