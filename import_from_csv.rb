require_relative 'helpers/csv_importer'
require_relative 'services/database'

conn = DatabaseConfig.connect

CSVImporter.import(conn)

conn.close
