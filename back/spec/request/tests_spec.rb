require 'spec_helper'

describe '/tests' do
  it 'GET /tests must return a JSON with all tests data' do
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
    
    get '/tests'
    
    expect(last_response.status).to eq 200
    expect(last_response.content_type).to include 'application/json'
    expect(JSON.parse(last_response.body)).to eq [
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
  end

  it 'GET /tests/:token must return a JSON with a complete test per token' do
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

    get '/tests/IQCZ17'

    expect(last_response.status).to eq 200
    expect(last_response.content_type).to include 'application/json'
    expect(JSON.parse(last_response.body)).to eq(
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
end
