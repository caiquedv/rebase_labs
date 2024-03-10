require 'sinatra'
require 'debug'
require_relative 'services/database'

Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

set :port, 3000
set :bind, '0.0.0.0'
set :server, :puma
