require_relative '../services/database'
require_relative '../helpers/csv_importer.rb'

post '/import' do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = '*'

  response = CSVImporter.import(params[:file][:tempfile])
  response.to_json
end
