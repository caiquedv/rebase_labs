require_relative '../config/database'

class Test
  attr_reader :teste

  def initialize(teste)
    @teste = teste
  end

  def self.all
    conn = DatabaseConfig.connect
    result = conn.exec('SELECT * FROM test;').entries
    conn.close
    result
  end
end