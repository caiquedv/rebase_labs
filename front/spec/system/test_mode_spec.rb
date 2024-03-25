require 'spec_helper'

RSpec.describe 'Test-Mode', type: :system do
  context 'When testing', js: true do
    it 'inserts true value on meta tag test-mode' do
      default_html = File.read(File.expand_path('../../views/index.html', __dir__))

      visit '/'

      expect(default_html).to include('REPLACE_TEST_MODE')
      rendered_html = page.html
      expect(rendered_html).not_to include('REPLACE_TEST_MODE')
      expect(rendered_html).to include('<meta name="test-mode" content="true">')
    end

    it 'guarantees the use of Fake Data to build the page' do
      visit '/'

      expect(page).to have_content 'Fake Token'
    end
  end  
end
