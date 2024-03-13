require 'sidekiq'
require_relative '../helpers/csv_importer.rb'

class CSVImportJob
  include Sidekiq::Job

  def perform(csv)
    puts 'performadoooooooo'
  end
end