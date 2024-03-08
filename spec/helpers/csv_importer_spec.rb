require 'debug'
require_relative '../../helpers/csv_importer'

RSpec.describe CSVImporter, type: :helper do
  describe '#import' do
    it 'should populate the database with tests' do
      expect(CSVImporter.import(@conn).count).to eq 3900
    end
  end
end
