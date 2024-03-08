require 'debug'
require 'spec_helper'
require_relative '../../helpers/csv_importer'

RSpec.describe CSVImporter, type: :helper do
  describe '#import' do
    it 'should populate the database with tests' do
      expect(CSVImporter.import.count).to eq 3900
    end
  end
end
