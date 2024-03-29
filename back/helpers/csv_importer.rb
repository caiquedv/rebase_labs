require 'csv'
require_relative '../services/database'

Dir[File.join(__dir__, '../models', '*.rb')].each { |file| require file }

class CSVImporter
  def self.import(csv_data = nil)
    connection = DatabaseConfig.connect

    rows = csv_data if csv_data
    rows = CSV.read('./data/data.csv', col_sep: ';') if csv_data.nil?

    columns = rows.shift
    
    patient = Patient.new
    doctor = Doctor.new
    exam = Exam.new
    test = Test.new

    patient_hash = {}
    doctor_hash = {}
    exam_hash = {}
    test_hash = {}

    connection.transaction do |conn|
      rows.each_with_index do |row, idx|
        patient_values = row.slice!(0, patient.class_attributes.count)
        doctor_values = row.slice!(0, doctor.class_attributes.count)
        exam_values = row.slice!(0, 2)
        test_values = row

        patient.class_attributes.map.with_index do |attr, idx|
          patient_hash[attr] = patient_values[idx]
        end

        doctor.class_attributes.map.with_index do |attr, idx|
          doctor_hash[attr] = doctor_values[idx]
        end
        
        exam_attrs = exam.class_attributes
        exam_attrs.shift(2)
        exam_attrs.map.with_index do |attr, idx|
          exam_hash[attr] = exam_values[idx]
        end

        test_attrs = test.class_attributes
        test_attrs.shift
        test_attrs.map.with_index do |attr, idx|
          test_hash[attr] = test_values[idx]
        end

        patient = Patient.create(patient_hash, conn)
        doctor = Doctor.create(doctor_hash, conn)

        exam_hash[:patient_id] = patient.id
        exam_hash[:doctor_id] = doctor.id
        exam = Exam.create(exam_hash, conn)
        
        test_hash[:exam_id] = exam.id
        test = Test.create(test_hash, conn)
      end
    end
    connection.close
  end

  def self.validate_csv(csv_rows)
    return ['CSV cannot be blank'] if csv_rows.empty?

    errors = []

    expected_columns = [
      "cpf",
      "nome paciente",
      "email paciente",
      "data nascimento paciente",
      "endereço/rua paciente",
      "cidade paciente",
      "estado patiente",
      "crm médico",
      "crm médico estado",
      "nome médico",
      "email médico",
      "token resultado exame",
      "data exame",
      "tipo exame",
      "limites tipo exame",
      "resultado tipo exame"
    ]

    csv_rows.map.with_index do |row, idx|
      error_msg_column = 'CSV does not have all or any columns at first line'
      error_msg_value = "CSV does not have all or any values at line #{idx + 1}"

      errors << error_msg_column if idx == 0 && row != expected_columns
      errors << error_msg_value if (idx == 0 && csv_rows.size == 1) || (idx != 0 && row.size != 16)
    end

    errors
  end
end
