require_relative '../services/database'
require_relative '../services/test_service'

get '/tests' do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = '*'

  TestService.parse_tests
end

get '/tests/:token' do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = '*'

  TestService.parse_tests_by_token(params[:token].upcase)
end
