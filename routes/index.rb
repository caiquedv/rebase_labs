require 'pg'
require 'sinatra'

get '/tests' do
  content_type :json
  conn = PG.connect( dbname: 'postgres', user: 'postgres', password: 'password', host: 'relabs-db' )
  conn.exec('DROP TABLE exames;')
  conn.exec('CREATE TABLE exames (teste VARCHAR);')
  conn.exec("INSERT INTO exames VALUES ('funcionou');")
  conn.exec('SELECT * FROM exames;').entries.to_json
end
