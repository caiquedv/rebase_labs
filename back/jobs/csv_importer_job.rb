require 'sidekiq'
require_relative '../helpers/csv_importer.rb'

class CSVImporterJob
  include Sidekiq::Job

  def perform(rows)
    CSVImporter.import(rows)
  end
end