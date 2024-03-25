require_relative '../services/database'
require_relative '../helpers/csv_importer.rb'
require_relative '../jobs/csv_importer_job.rb'
require 'csv'

post '/import' do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = '*'

  rows = CSV.read(params[:file][:tempfile], col_sep: ';')

  invalid_csv = CSVImporter.validate_csv(rows)

  return { error: invalid_csv.join(', ') }.to_json if invalid_csv.any?

  CSVImporterJob.perform_async(rows)

  { done: 'Your document has been enqueued to import' }.to_json
end
