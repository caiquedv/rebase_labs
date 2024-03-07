require 'sinatra'
require 'debug'
require_relative 'services/database'

Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

DatabaseConfig.setup

set :port, 3000
set :bind, '0.0.0.0'
set :server, :puma
