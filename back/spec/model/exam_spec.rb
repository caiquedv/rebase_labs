require 'spec_helper'
require_relative '../../models/exam'
require_relative '../../models/doctor'
require_relative '../../models/patient'

RSpec.describe Exam, type: :model do
  context '.create' do
    describe 'Should create an Exam on database' do
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

        doctor = Doctor.create({
          crm: 'B000BJ20J4',
          crm_state: 'PI',
          name: 'Maria Luiza',
          email: 'denna@wisozk.biz'
        }, @conn)

        exam = Exam.create({
          patient_id: patient.id,
          doctor_id: doctor.id,
          result_token: 'IQCZ17',
          result_date: '2021-08-05'
        }, @conn)
        
        expect(exam.id).not_to be_nil
        expect(exam.patient_id).to eq patient.id
        expect(exam.doctor_id).to eq doctor.id
        expect(exam.result_token).to eq 'IQCZ17'
        expect(exam.result_date).to eq '2021-08-05'
      end

      it 'failure' do
        allow_any_instance_of(PG::Connection).to receive(:exec_params).and_raise(PG::Error, 'Database error')

        exam = Exam.create({
          patient_id: '1',
          doctor_id: '1',
          result_token: 'IQCZ17',
          result_date: '2021-08-05'
        }, @conn)

        expect(exam.id).to be_nil
        expect(exam.errors[:base]).to eq("Error when executing SQL query: Database error")
      end
    end
  end

  context '.find_by_token' do
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

      doctor = Doctor.create({
        crm: 'B000BJ20J4',
        crm_state: 'PI',
        name: 'Maria Luiza',
        email: 'denna@wisozk.biz'
      }, @conn)

      exam = Exam.create({
        patient_id: patient.id,
        doctor_id: doctor.id,
        result_token: 'IQCZ17',
        result_date: '2021-08-05'
      }, @conn)

      exam = Exam.find_by_token(exam.result_token, @conn)

      expect(exam).not_to be_nil
      expect(exam.result_token).to eq 'IQCZ17'
    end
  end

  context '#valid?' do
    describe 'Should validate an Exam' do
      it 'with empty fields' do
        exam = Exam.new({})

        expect(exam).not_to be_valid
        expect(exam.errors.values.count('cannot be empty')).to eq 3
      end

      it 'with existing result token' do
        patient = Patient.create({
          cpf: '412.625.735-72',
          name: 'John Cena',
          email: 'john@email.com',
          birthdate: '1990-03-08',
          address: 'Baker Street 221',
          city: 'London',
          state: 'LB'
        }, @conn)

        doctor = Doctor.create({
          crm: 'B000BJ20J4',
          crm_state: 'PI',
          name: 'Maria Luiza',
          email: 'denna@wisozk.biz'
        }, @conn)

        Exam.create({
          patient_id: patient.id,
          doctor_id: doctor.id,
          result_token: 'IQCZ17',
          result_date: '2021-08-05'
        }, @conn)

        exam = Exam.new({ result_token: 'IQCZ17' })

        expect(exam).not_to be_valid
        expect(exam.errors.values.count('must be unique')).to eq 1
      end
    end
  end
end
