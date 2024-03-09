DB_CONFIG = {
  dbname: ENV['RACK_ENV'] || 'development',
  host: 'relabs-db',
  user: 'user',
  password: 'password',
  port: 5432
}.freeze