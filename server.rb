require 'sinatra'
require './routes/index.rb'

set :port, 3000
set :bind, '0.0.0.0'
set :server, :puma
