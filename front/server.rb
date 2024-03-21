require 'sinatra'
require 'debug'
require 'faraday'
require_relative 'services/fetch.rb'

set :port, 2000
set :bind, '0.0.0.0'
set :server, :puma

get '/' do
  test_mode = ENV['TEST_MODE'] == 'true' ? 'true' : 'false'
puts test_mode
  content_type 'text/html'
  html_content = File.read('./views/index.html')
  modified_html_content = html_content.gsub('<meta name="test-mode" content="false">', %Q[<meta name="test-mode" content="#{test_mode}">])
  modified_html_content
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
