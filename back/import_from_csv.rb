require_relative 'helpers/csv_importer'

conn = DatabaseConfig.connect

CSVImporter.import

conn.close
