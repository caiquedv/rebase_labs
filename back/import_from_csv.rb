require_relative 'back/helpers/csv_importer'
require_relative 'back/services/database'

conn = DatabaseConfig.connect

CSVImporter.import(conn)

conn.close
