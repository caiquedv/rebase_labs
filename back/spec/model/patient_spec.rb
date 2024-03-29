require 'spec_helper'
require_relative '../../models/patient'

RSpec.describe Patient, type: :model do
  context '.create' do
    describe 'Should create a Patient on database' do
      it 'success' do 
        patient = Patient.create({
          cpf: '412.625.735-72',
          name: 'John Cena',
          email: 'john@email.com',
          birthdate: '1990-03-08',
          address: 'Baker Street 221',
          city: 'London',
          state: 'LB'
        }, @conn)
        
        expect(patient.id).not_to be_nil
        expect(patient.cpf).to eq '412.625.735-72'
        expect(patient.name).to eq 'John Cena'
        expect(patient.email).to eq 'john@email.com'
        expect(patient.birthdate).to eq '1990-03-08'
        expect(patient.address).to eq 'Baker Street 221'
        expect(patient.city).to eq 'London'
        expect(patient.state).to eq 'LB'
      end

      it 'failure' do
        allow_any_instance_of(PG::Connection).to receive(:exec_params).and_raise(PG::Error, 'Database error')

        patient = Patient.create({
          cpf: '412.625.735-72',
          name: 'John Cena',
          email: 'john@email.com',
          birthdate: '1990-03-08',
          address: 'Baker Street 221',
          city: 'London',
          state: 'LB'
        }, @conn)

        expect(patient.id).to be_nil
        expect(patient.errors[:base]).to eq("Error when executing SQL query: Database error")
      end
    end
  end

  context '.find_by_cpf' do
    it 'success' do
      patient = Patient.create({
        cpf: '412.625.735-72',
        name: 'John Cena',
        email: 'john@email.com',
        birthdate: '1990-03-08',
        address: 'Baker Street 221',
        city: 'London',
        state: 'LB'
      }, @conn)

      patient = Patient.find_by_cpf(patient.cpf, @conn)

      expect(patient).not_to be_nil
      expect(patient.cpf).to eq '412.625.735-72'
    end
  end

  context '#valid?' do
    describe 'Should validate a Patient' do
      it 'with empty fields' do
        patient = Patient.new({
          cpf: '',
          name: '',
          email: '',
          birthdate: '',
          address: '',
          city: '',
          state: ''
        })

        expect(patient).not_to be_valid
        expect(patient.errors.values.count('cannot be empty')).to eq 7
      end

      it 'with existing cpf' do
        Patient.create({
          cpf: '412.625.735-72',
          name: 'John Cena',
          email: 'john@email.com',
          birthdate: '1990-03-08',
          address: 'Baker Street 221',
          city: 'London',
          state: 'LB'
        }, @conn)

        patient = Patient.new({ cpf: '412.625.735-72' })

        expect(patient).not_to be_valid
        expect(patient.errors.values.count('must be unique')).to eq 1
      end
    end
  end
end
