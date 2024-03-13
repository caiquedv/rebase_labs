require 'spec_helper'
require_relative '../../services/fetch.rb'

describe 'User visit home page', js: true do
  it "sees a list of exams coming from the backend application" do    
    api_response = [
      {
        "result_token": "IQCZ17",
        "result_date": "2021-08-05",
        "patient": {
          "cpf": "048.973.170-88",
          "city": "Ituverava",
          "name": "Emilly Batista Neto",
          "email": "gerald.crona@ebert-quigley.com",
          "state": "Alagoas",
          "address": "165 Rua Rafaela",
          "birthdate": "2001-03-11"
        },
        "doctor": {
          "crm": "B000BJ20J4",
          "name": "Maria Luiza Pires",
          "email": "denna@wisozk.biz",
          "crm_state": "PI"
        },
        "tests": [
          {
            "type": "hemácias",
            "type_limits": "45-52",
            "type_results": "97"
          },
          {
            "type": "leucócitos",
            "type_limits": "9-61",
            "type_results": "89"
          }
        ]  
      }
    ].to_json

    allow(Fetch).to receive(:all).and_return(api_response)
    
    visit '/'

    expect(page).to have_content 'Token: IQCZ17'
    expect(page).to have_content 'Result Date: 2021-08-05'
    expect(page).to have_content 'Patient: Emilly Batista Neto'
    expect(page).to have_content 'CPF: 048.973.170-88'
    expect(page).to have_content 'City: Ituverava'
    expect(page).to have_content 'State: Alagoas'
    expect(page).to have_content 'Address: 165 Rua Rafaela'
    expect(page).to have_content 'Birthdate: 2001-03-11'
    expect(page).to have_content 'Doctor: Maria Luiza Pires'
    expect(page).to have_content 'CRM: B000BJ20J4'
    expect(page).to have_content 'CRM State: PI'
    expect(page).to have_content 'Type: hemácias'
    expect(page).to have_content 'Type Limits: 45-52'
    expect(page).to have_content 'Type Results: 97'
    expect(page).to have_content 'Type: leucócitos'
    expect(page).to have_content 'Type Limits: 9-61'
    expect(page).to have_content 'Type Results: 89'
  end

  it 'Must search for an exam by token' do
    api_response_all = [
      {
        "result_token": "IQCZ17",
        "result_date": "2021-08-05",
        "patient": {
          "cpf": "048.973.170-88",
          "city": "Ituverava",
          "name": "Emilly Batista Neto",
          "email": "gerald.crona@ebert-quigley.com",
          "state": "Alagoas",
          "address": "165 Rua Rafaela",
          "birthdate": "2001-03-11"
        },
        "doctor": {
          "crm": "B000BJ20J4",
          "name": "Maria Luiza Pires",
          "email": "denna@wisozk.biz",
          "crm_state": "PI"
        },
        "tests": [
          {
            "type": "hemácias",
            "type_limits": "45-52",
            "type_results": "97"
          },
          {
            "type": "leucócitos",
            "type_limits": "9-61",
            "type_results": "89"
          }
        ]  
      }
    ]
    api_response_by_token = api_response_all.first.to_json

    allow(Fetch).to receive(:all).and_return(api_response_all.to_json)
    visit '/'
    fill_in 'token', with: 'IQCZ17'
    allow(Fetch).to receive(:find_by_token).and_return(api_response_by_token)
    click_on 'Search'
    
    expect(page).to have_content 'Token: IQCZ17'
    expect(page).to have_content 'Result Date: 2021-08-05'
    expect(page).to have_content 'Patient: Emilly Batista Neto'
    expect(page).to have_content 'CPF: 048.973.170-88'
    expect(page).to have_content 'City: Ituverava'
    expect(page).to have_content 'State: Alagoas'
    expect(page).to have_content 'Address: 165 Rua Rafaela'
    expect(page).to have_content 'Birthdate: 2001-03-11'
    expect(page).to have_content 'Doctor: Maria Luiza Pires'
    expect(page).to have_content 'CRM: B000BJ20J4'
    expect(page).to have_content 'CRM State: PI'
    expect(page).to have_content 'Type: hemácias'
    expect(page).to have_content 'Type Limits: 45-52'
    expect(page).to have_content 'Type Results: 97'
    expect(page).to have_content 'Type: leucócitos'
    expect(page).to have_content 'Type Limits: 9-61'
    expect(page).to have_content 'Type Results: 89'
  end
end
  