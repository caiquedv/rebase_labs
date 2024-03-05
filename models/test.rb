require 'pg'
require_relative '../config'

class Test
  def self.db_test
    conn = PG.connect(DB_CONFIG)
    conn.exec('DROP TABLE IF EXISTS teste;')
    conn.exec('CREATE TABLE teste (ok VARCHAR);')
    conn.exec("INSERT INTO teste VALUES ('funcionou');")
    result = conn.exec('SELECT * FROM teste;').entries
    conn.close    

    result
  end
end