require 'spec_helper'
require_relative '../../services/test_service'

RSpec.describe TestService, type: :service do
  context '.parse_tests' do
    it 'must return a JSON with all tests' do
      db_result = [
        {
          'result_token' => 'IQCZ17',
          'result_date' => '2021-08-05',
          'patient' => {
            'cpf' => '048.973.170-88',
            'city' => 'Ituverava',
            'name' => 'Emilly Batista Neto',
            'email' => 'gerald.crona@ebert-quigley.com',
            'state' => 'Alagoas',
            'address' => '165 Rua Rafaela',
            'birthdate' => '2001-03-11'
          }.to_json,
          'doctor' => {
            'crm' => 'B000BJ20J4',
            'name' => 'Maria Luiza Pires',
            'email' => 'denna@wisozk.biz',
            'crm_state' => 'PI'
          }.to_json,
          'tests' => [
            {
              'type' => 'hemácias',
              'limits' => '45-52',
              'results' => '97'
            },
            {
              'type' => 'leucócitos',
              'limits' => '9-61',
              'results' => '89'
            }
          ].to_json
        }
      ]

      db_connection = double('PG::Connection', exec: db_result, close: nil)
      allow(DatabaseConfig).to receive(:connect).and_return(db_connection)

      parsed_tests = JSON.parse(TestService.parse_tests)

      expect(parsed_tests).to eq(
        [
          {
            'result_token' => 'IQCZ17',
            'result_date' => '2021-08-05',
            'patient' => {
              'cpf' => '048.973.170-88',
              'city' => 'Ituverava',
              'name' => 'Emilly Batista Neto',
              'email' => 'gerald.crona@ebert-quigley.com',
              'state' => 'Alagoas',
              'address' => '165 Rua Rafaela',
              'birthdate' => '2001-03-11'
            },
            'doctor' => {
              'crm' => 'B000BJ20J4',
              'name' => 'Maria Luiza Pires',
              'email' => 'denna@wisozk.biz',
              'crm_state' => 'PI'
            },
            'tests' => [
              {
                'type' => 'hemácias',
                'limits' => '45-52',
                'results' => '97'
              },
              {
                'type' => 'leucócitos',
                'limits' => '9-61',
                'results' => '89'
              }
            ]
          }
        ]
      )
    end
  end

  context '.parse_tests_by_token' do
    it 'must return a JSON with full test per token' do
      db_result = [
        {
          'result_token' => 'IQCZ17',
          'result_date' => '2021-08-05',
          'patient' => {
            'cpf' => '048.973.170-88',
            'city' => 'Ituverava',
            'name' => 'Emilly Batista Neto',
            'email' => 'gerald.crona@ebert-quigley.com',
            'state' => 'Alagoas',
            'address' => '165 Rua Rafaela',
            'birthdate' => '2001-03-11'
          }.to_json,
          'doctor' => {
            'crm' => 'B000BJ20J4',
            'name' => 'Maria Luiza Pires',
            'email' => 'denna@wisozk.biz',
            'crm_state' => 'PI'
          }.to_json,
          'tests' => [
            {
              'type' => 'hemácias',
              'limits' => '45-52',
              'results' => '97'
            },
            {
              'type' => 'leucócitos',
              'limits' => '9-61',
              'results' => '89'
            }
          ].to_json
        }
      ]

      db_connection = double('PG::Connection', exec: db_result, close: nil)
      allow(DatabaseConfig).to receive(:connect).and_return(db_connection)

      parsed_tests = JSON.parse(TestService.parse_tests_by_token('IQCZ17'))
      
      expect(parsed_tests).to eq(
        {
          'result_token' => 'IQCZ17',
          'result_date' => '2021-08-05',
          'patient' => {
            'cpf' => '048.973.170-88',
            'city' => 'Ituverava',
            'name' => 'Emilly Batista Neto',
            'email' => 'gerald.crona@ebert-quigley.com',
            'state' => 'Alagoas',
            'address' => '165 Rua Rafaela',
            'birthdate' => '2001-03-11'
          },
          'doctor' => {
            'crm' => 'B000BJ20J4',
            'name' => 'Maria Luiza Pires',
            'email' => 'denna@wisozk.biz',
            'crm_state' => 'PI'
          },
          'tests' => [
            {
              'type' => 'hemácias',
              'limits' => '45-52',
              'results' => '97'
            },
            {
              'type' => 'leucócitos',
              'limits' => '9-61',
              'results' => '89'
            }
          ]
        }
      )
    end

    it 'error when token is invalid' do
      db_result = nil
    
      db_connection = double('PG::Connection', exec: db_result, close: nil)
      allow(DatabaseConfig).to receive(:connect).and_return(db_connection)
    
      parsed_tests = JSON.parse(TestService.parse_tests_by_token('Invalid 123'))
      expect(parsed_tests).to eq({'error'=>'Invalid token'})
    end    
  end
end
