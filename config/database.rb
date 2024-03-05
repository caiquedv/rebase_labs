require 'pg'
require_relative '../config'

class DatabaseConfig
  def self.connect
    PG.connect(DB_CONFIG)
  end

  def self.test_setup
    conn = connect
    conn.exec('DROP TABLE IF EXISTS test;')
    conn.exec('CREATE TABLE test (ping VARCHAR);')
    conn.exec("INSERT INTO test VALUES ('pong');")
    conn.close
    puts "Setup de teste concluído."
  end
end