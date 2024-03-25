require 'spec_helper'

RSpec.describe 'Import CSV', type: :system do
  context 'User imports a CSV file', js: true do
    it 'success' do
      visit '/'
      attach_file('csvFile', File.expand_path('../support/small_data.csv', __dir__), make_visible: true)
      message = accept_alert do
        click_on 'Upload'
      end
      
      expect(message).to eq 'Your document has been enqueued to import' 
    end

    it 'fails to upload without file' do 
      visit '/'
      message = accept_alert do
        click_on 'Upload'
      end
      
      expect(message).to eq 'Please select a CSV file.' 
    end

    it 'fails with invalid CSV file' do 
      visit '/'
      attach_file('csvFile', File.expand_path('../support/invalid_data.csv', __dir__), make_visible: true)
      message = accept_alert do
        click_on 'Upload'
      end
      
      expect(message).to eq 'Insert a valid CSV File'
    end
  end
end
