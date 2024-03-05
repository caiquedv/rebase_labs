require_relative '../repositories/test_repository'

before '/tests' do
  DatabaseConfig.test_setup
end

get '/tests' do
  content_type :json
  TestRepository.all.to_json
end
