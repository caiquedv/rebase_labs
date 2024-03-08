require 'pg'
require_relative '../config/config'

class DatabaseConfig
  def self.connect(config = nil)
    PG.connect(config || DB_CONFIG)
  end
end
