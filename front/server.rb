require 'sinatra'
require 'debug'
require 'faraday'
require_relative 'services/fetch.rb'

set :port, 2000
set :bind, '0.0.0.0'
set :server, :puma

get '/' do
  content_type 'text/html'
  File.open('./views/index.html')
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
