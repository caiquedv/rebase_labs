require 'spec_helper'
require_relative '../../jobs/csv_importer_job.rb'

RSpec.describe CSVImporterJob, type: :job do
  it '#perform' do
    file_path = File.expand_path('../support/small_data.csv', __dir__) 

    rows = CSV.read(file_path, col_sep: ';')

    CSVImporterJob.perform_sync(rows)

    expect(@conn.exec('SELECT COUNT(*) FROM patients;').entries.first.count).to eq 1
    expect(@conn.exec('SELECT COUNT(*) FROM doctors;').entries.first.count).to eq 1
    expect(@conn.exec('SELECT COUNT(*) FROM exams;').entries.first.count).to eq 1
    expect(@conn.exec('SELECT COUNT(*) FROM tests;').entries.first.count).to eq 1
  end
end
