require 'spec_helper'

RSpec.describe 'Home', type: :system do
  context 'User visits home page', js: true do
    it 'sees a list of links of exams' do
      visit '/'

      expect(page).to have_selector('thead tr th', text: 'Token')
      expect(page).to have_selector('thead tr th', text: 'Result Date')
      expect(page).to have_selector('thead tr th', text: 'Patient')
      expect(page).to have_selector('thead tr th', text: 'CPF')
      expect(page).to have_selector('thead tr th', text: 'Doctor')
      expect(page).to have_selector('thead tr th', text: 'CRM')

      expect(page).to have_selector('tbody tr td', text: 'Fake Token')
      expect(page).to have_selector('tbody tr td', text: '2021/08/05')
      expect(page).to have_selector('tbody tr td', text: 'Emilly Batista Neto')
      expect(page).to have_selector('tbody tr td', text: '048.973.170-88')
      expect(page).to have_selector('tbody tr td', text: 'Maria Luiza Pires')
      expect(page).to have_selector('tbody tr td', text: 'B000BJ20J4/PI')
    end

    pending '2. visualização completa'
    pending '3. paginação da listagem'
  end  
end
