require 'dotenv/load'

DB_CONFIG = {
  dbname: ENV['RACK_ENV'] || 'development',
  host: ENV['POSTGRES_HOST'],
  user: ENV['POSTGRES_USER'],
  password: ENV['POSTGRES_PASSWORD'],
  port: ENV['POSTGRES_PORT']
}.freeze