require 'sinatra'
require_relative '../models/test'

get '/tests' do
  content_type :json
  Test.db_test.to_json
end