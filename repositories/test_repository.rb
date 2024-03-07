require_relative '../models/test'

class TestRepository
  def self.all(conn)
    result = conn.exec('SELECT * FROM tests;').entries
    result
  end
end
