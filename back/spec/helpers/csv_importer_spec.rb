require 'spec_helper'
require_relative '../../helpers/csv_importer'

RSpec.describe CSVImporter, type: :helper do
  describe '#import' do
    it 'should populate the database with tests' do
      doctor = 'José Aldo'
      fake_csv = [
        ['cpf', 'nome paciente', 'email paciente', 'data nascimento paciente', 'endereço/rua paciente', 'cidade paciente', 'estado paciente', 'crm médico', 'crm médico estado', 'nome médico', 'email médico', 'token resultado exame', 'data exame', 'tipo exame', 'limites tipo exame', 'resultado tipo exame'],
        ['048.973.170-88', 'Emilly Batista Neto', 'gerald.crona@ebert-quigley.com', '2001-03-11', '165 Rua Rafaela', 'Ituverava', 'Alagoas', 'B000BJ20J4', 'PI', doctor, 'denna@wisozk.biz', 'IQCZ17', '2021-08-05', 'hemácias', '45-52', '97'],
        ['066.126.400-90', 'Matheus Barroso', 'maricela@streich.com', '1972-03-09', '9378 Rua Stella Braga', 'Senador Elói de Souza', 'Pernambuco', 'B000BJ20J4', 'PI', doctor, 'kendra@nolan-sawayn.co', 'T9O6AI', '2021-11-21', 'hdl', '19-75', '3'],
        ['089.034.562-70', 'Patricia Gentil', 'herta_wehner@krajcik.name', '1998-02-25', '5334 Rodovia Thiago Bittencourt', 'Jequitibá', 'Paraná', 'B0002W2RBG', 'CE', 'Dra. Isabelly Rêgo', 'diann_klein@schinner.org', 'TJUXC2', '2021-10-05', 'plaquetas','11-93', '26'],
        ['089.034.562-70', 'Patricia Gentil', 'herta_wehner@krajcik.name', '1998-02-25', '5334 Rodovia Thiago Bittencourt', 'Jequitibá', 'Paraná', 'B0002W2RBG', 'CE', 'Dra. Isabelly Rêgo', 'diann_klein@schinner.org', 'TJUXC2', '2021-10-05', 'hemácias', '45-52', '85']
      ]
      
      allow(CSV).to receive(:read).and_return(fake_csv)
      CSVImporter.import

      patients = @conn.exec('SELECT * FROM patients;').entries
      doctors = @conn.exec('SELECT * FROM doctors;').entries
      exams = @conn.exec('SELECT * FROM exams;').entries
      tests = @conn.exec('SELECT * FROM tests;').entries
      expect(patients.count).to eq 3
      expect(doctors.count).to eq 2
      expect(exams.count).to eq 3
      expect(tests.count).to eq 4
    end
  end
end
