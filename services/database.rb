require 'pg'
require_relative '../config/config'

class DatabaseConfig
  def self.connect(config = nil)
    PG.connect(config ? config : DB_CONFIG)
  end

  def self.setup
    conn = connect
    conn.exec('DROP TABLE IF EXISTS tests;')
    conn.exec('CREATE TABLE IF NOT EXISTS tests (ping VARCHAR);')
    conn.exec("INSERT INTO tests VALUES ('pong');")
    conn.close

    conn = connect(DB_CONFIG_TEST)
    conn.exec('DROP TABLE IF EXISTS tests;')
    conn.exec('CREATE TABLE IF NOT EXISTS tests (ping VARCHAR);')
    conn.exec("INSERT INTO tests VALUES ('pong');")
    conn.close
    puts "Setup de concluído."
  end
end
