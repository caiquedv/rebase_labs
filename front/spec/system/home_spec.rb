require 'spec_helper'

RSpec.describe 'Home', type: :system do
  context 'User visits home page', js: true do
    it 'sees a list of exams' do
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

    it 'and clicks on an exam' do
      visit '/'
      find('tbody tr:first-child').click

      expect(page).to have_selector('thead tr th', text: 'Token: Fake Token')
      expect(page).to have_selector('thead tr th', text: 'Result Date: 2021/08/05')
      expect(page).to have_selector('thead tr th', text: 'Doctor: Maria Luiza Pires')
      expect(page).to have_selector('thead tr th', text: 'CRM: B000BJ20J4/PI')
      expect(page).to have_selector('thead tr th', text: 'Patient: Emilly Batista Neto')
      expect(page).to have_selector('thead tr th', text: 'CPF: 048.973.170-88')
      expect(page).to have_selector('thead tr th', text: 'Date of birth: 2001/03/11')
      expect(page).to have_selector('thead tr th', text: 'Address: 165 Rua Rafaela - Ituverava / Alagoas')
      expect(page).to have_selector('thead tr th', text: 'Test Type')
      expect(page).to have_selector('thead tr th', text: 'Limits')
      expect(page).to have_selector('thead tr th', text: 'Results')
      expect(page).to have_selector('tbody tr td', text: 'hemácias')
      expect(page).to have_selector('tbody tr td', text: '45 to 52')
      expect(page).to have_selector('tbody tr td', text: '97')
      expect(page).to have_selector('tbody tr td', text: 'leucócitos')
      expect(page).to have_selector('tbody tr td', text: '9 to 61')
      expect(page).to have_selector('tbody tr td', text: '89')
    end

    it 'sees paged list of exams' do
      visit '/'
      click_on '2'

      expect(page).to have_selector '.active-page', text: '2'
      expect(page).to have_selector('tbody tr td', text: 'Page 2 Token')
      expect(page).not_to have_selector('tbody tr td', text: 'Fake Token')
    end
  end  
end
