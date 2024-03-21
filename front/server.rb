require 'sinatra'
require 'debug'
require 'faraday'
require_relative 'services/fetch.rb'

set :port, 2000
set :bind, '0.0.0.0'
set :server, :puma
set :test_mode, false

get '/' do
  test_mode = settings.test_mode ? 'true' : 'false'
  
  content_type 'text/html'
  html_content = File.read('./views/index.html')
  modified_html_content = html_content.gsub('REPLACE_TEST_MODE', test_mode)
  modified_html_content
end

get '/set-test-mode' do
  settings.test_mode = true
  "Test mode set"
end

get '/reset-test-mode' do
  settings.test_mode = false
  "Test mode reset"
end

get '/fetch' do
  content_type :json
  Fetch.all
end

get '/fetch/:token' do
  content_type :json
  Fetch.find_by_token(params[:token])
end

post '/fetch/csv' do
  content_type :json
  Fetch.import_csv(params[:csvFile][:tempfile])
end
