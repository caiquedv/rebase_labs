require 'spec_helper'
require_relative '../../models/test'

RSpec.describe Test, type: :model do
  context '.create' do
    describe 'Should create a Test on database' do
      it 'success' do 
        patient = Patient.create({
          cpf: '412.625.735-72',
          name: 'John Cena',
          email: 'john@email.com',
          birthdate: '1990-03-08',
          address: 'Baker Street 221',
          city: 'London',
          state: 'LB'
        })

        doctor = Doctor.create({
          crm: 'B000BJ20J4',
          crm_state: 'PI',
          name: 'Maria Luiza',
          email: 'denna@wisozk.biz'
        })

        exam = Exam.create({
          patient_id: patient.id,
          doctor_id: doctor.id,
          result_token: 'IQCZ17',
          result_date: '2021-08-05'
        })

        test = Test.create({
          exam_id: exam.id,
          test_type: 'hemácias',
          test_type_limits: '45-52',
          test_type_results: '97'
        })
        
        expect(test.id).not_to be_nil
        expect(test.test_type).to eq 'hemácias'
        expect(test.test_type_limits).to eq '45-52'
        expect(test.test_type_results).to eq '97'
      end

      it 'failure' do
        allow_any_instance_of(PG::Connection).to receive(:exec_params).and_raise(PG::Error, 'Database error')

        test = Test.create({
          exam_id: '1',
          test_type: 'hemácias',
          test_type_limits: '45-52',
          test_type_results: '97'
        })

        expect(test.id).to be_nil
        expect(test.errors[:base]).to eq("Error when executing SQL query: Database error")
      end
    end
  end

  context '#valid?' do
    describe 'Should validate a Test' do
      it 'with empty fields' do
        test = Test.create

        expect(test.errors.values.count('cannot be empty')).to eq 3
      end
    end
  end
end
