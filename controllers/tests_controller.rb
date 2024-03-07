require_relative '../repositories/test_repository'
require_relative '../services/database'

get '/tests' do
  content_type :json
  conn = DatabaseConfig.connect
  result = TestRepository.all(conn)
  conn.close
  result.to_json
end
