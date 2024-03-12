require_relative '../services/database'
require_relative '../services/test_service'

get '/tests' do
  content_type :json
  response.header['Access-Control-Allow-Origin'] = '*'

  TestService.parse_tests
end
