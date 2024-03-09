require 'spec_helper'
require_relative '../../models/doctor'

RSpec.describe Doctor, type: :model do
  context '.create' do
    describe 'Should create a Doctor on database' do
      it 'success' do 
        doctor = Doctor.create({
          crm: 'B000BJ20J4',
          crm_state: 'PI',
          name: 'Maria Luiza',
          email: 'denna@wisozk.biz'
        })
        
        expect(doctor.id).not_to be_nil
        expect(doctor.crm).to eq 'B000BJ20J4'
        expect(doctor.crm_state).to eq 'PI'
        expect(doctor.name).to eq 'Maria Luiza'
        expect(doctor.email).to eq 'denna@wisozk.biz'
      end

      it 'failure' do
        allow_any_instance_of(PG::Connection).to receive(:exec_params).and_raise(PG::Error, 'Database error')

        doctor = Doctor.create({
          crm: 'B000BJ20J4',
          crm_state: 'PI',
          name: 'Maria Luiza',
          email: 'denna@wisozk.biz'
        })

        expect(doctor.id).to be_nil
        expect(doctor.errors[:base]).to eq("Error when executing SQL query: Database error")
      end
    end
  end

  context '#valid?' do
    describe 'Should validate a Doctor' do
      it 'with empty fields' do
        doctor = Doctor.create({
          crm: '',
          crm_state: '',
          name: '',
          email: ''
        })

        expect(doctor.errors.values.count('cannot be empty')).to eq 4
      end

      it 'with existing crm per state' do
        Doctor.create({
          crm: 'B000BJ20J4',
          crm_state: 'PI',
          name: 'Maria Luiza',
          email: 'denna@wisozk.biz'
        })

        doctor = Doctor.create({
          crm: 'B000BJ20J4',
          crm_state: 'PI'
        })

        expect(doctor.errors.values.count('must be unique per state')).to eq 1
      end
    end
  end
end
