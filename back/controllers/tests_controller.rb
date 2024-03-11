require_relative '../services/database'
require_relative '../services/test_service'

get '/tests' do
  content_type :json

  TestService.parse_tests
end
