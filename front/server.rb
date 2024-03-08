require 'sinatra'
require 'debug'

set :port, 2000
set :bind, '0.0.0.0'
set :server, :puma

get '/' do
  content_type 'text/html'
  File.open('./views/index.html')
end
