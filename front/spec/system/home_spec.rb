require 'spec_helper'

RSpec.describe 'home', type: :system do
  describe 'User visit home page', js: true do
    it 'sees a list of exams' do
      visit '/'
      
      expect(page).to have_content 'Token: Fake Data'
      expect(page).to have_content 'Result Date: 2021/08/05'
      expect(page).to have_content 'Patient: Emilly Batista Neto'
      expect(page).to have_content 'CPF: 048.973.170-88'
      expect(page).to have_content 'Address: 165 Rua Rafaela - Ituverava / Alagoas'
      expect(page).to have_content 'Date of birth: 2001/03/11'
      expect(page).to have_content 'Doctor: Maria Luiza Pires'
      expect(page).to have_content 'CRM: B000BJ20J4-PI'
      expect(page).to have_content 'hemácias'
      expect(page).to have_content '45 to 52'
      expect(page).to have_content '97'
      expect(page).to have_content 'leucócitos'
      expect(page).to have_content '9 to 61'
      expect(page).to have_content '89'
    end
  end  
end
