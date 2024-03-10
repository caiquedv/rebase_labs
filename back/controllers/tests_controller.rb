require_relative '../services/database'

get '/tests' do
  content_type :json

  conn = DatabaseConfig.connect
  result = conn.exec('SELECT * FROM tests;').entries
  conn.close

  result.to_json
end
