require 'spec_helper'
require_relative '../../services/test_service'

RSpec.describe TestService, type: :service do
  context '.parse_tests' do
    it 'parses test results correctly' do
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
              'test_type' => 'hemácias',
              'test_type_limits' => '45-52',
              'test_type_results' => '97'
            },
            {
              'test_type' => 'leucócitos',
              'test_type_limits' => '9-61',
              'test_type_results' => '89'
            }
          ].to_json
        }
      ]

      db_connection = double('PG::Connection', exec: db_result, close: nil)
      allow(DatabaseConfig).to receive(:connect).and_return(db_connection)

      
      parsed_tests = JSON.parse(TestService.parse_tests)

      expect(parsed_tests).to eq([{"result_token"=>"IQCZ17",
      "result_date"=>"2021-08-05",
      "patient"=>
       {"cpf"=>"048.973.170-88",
        "name"=>"Emilly Batista Neto",
        "email"=>"gerald.crona@ebert-quigley.com",
        "birthdate"=>"2001-03-11",
        "address"=>"165 Rua Rafaela",
        "city"=>"Ituverava",
        "state"=>"Alagoas"},
      "doctor"=>
       {"crm"=>"B000BJ20J4",
        "name"=>"Maria Luiza Pires",
        "email"=>"denna@wisozk.biz",
        "crm_state"=>"PI"},
      "tests"=>
       [{"test_type"=>"hemácias", "test_type_limits"=>"45-52", "test_type_results"=>"97"},
        {"test_type"=>"leucócitos", "test_type_limits"=>"9-61", "test_type_results"=>"89"}]}])
    end
  end
end
