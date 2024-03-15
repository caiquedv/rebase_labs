require 'spec_helper'
require_relative '../../controllers/import_controller.rb'

describe 'POST /import' do
  it 'must enqueue imported csv data' do
    file_path = File.expand_path('../support/small_data.csv', __dir__) 

    fake_data = CSV.read(file_path, col_sep: ';')

    fake_csv = 'spec/support/small_data.csv'
    spy_csv_importer_job = spy('CSVImporterJob')
    stub_const('CSVImporterJob', spy_csv_importer_job)

    allow(CSV).to receive(:read).and_return(fake_data)

    post '/import', file: Rack::Test::UploadedFile.new(fake_csv, 'text/csv')

    expect(CSVImporterJob).to have_received(:perform_async).with(fake_data)
    expect(last_response.content_type).to include 'application/json'
    json_response = JSON.parse(last_response.body, symbolize_names: true)
    expect(json_response[:done]).not_to be_nil
  end
end
