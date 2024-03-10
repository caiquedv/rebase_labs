require_relative '../services/database'

class Patient
  attr_accessor :id, :cpf, :name, :email, :birthdate, :address, :city, :state, :created_at, :updated_at, :errors

  def initialize(params = {})
    @id = params[:id]
    @cpf = params[:cpf]
    @name = params[:name]
    @email = params[:email]
    @birthdate = params[:birthdate]
    @address = params[:address]
    @city = params[:city]
    @state = params[:state]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @errors = {}
  end

  def self.create(attributes = {}, conn, close_conn: false)
    conn ||= DatabaseConfig.connect

    patient = new(attributes)

    begin
      if patient.valid?(conn)
        query = "
          INSERT INTO patients (#{attributes.keys.join(', ')})
          VALUES (#{attributes.values.map.with_index { |values, idx| "$#{idx + 1}"  }.join(', ') })
          RETURNING *;
        "
        result = conn.exec_params(query, attributes.values).entries.first

        patient = new(result.transform_keys(&:to_sym)) if result
      elsif patient.errors[:cpf]
        patient = Patient.find_by_cpf(attributes[:cpf], conn)
      end
    rescue PG::Error => e
      patient.errors[:base] = "Error when executing SQL query: #{e.message}"
    ensure
      conn.close if close_conn && conn
    end
    
    patient
  end

  def self.find_by_cpf(cpf, conn = nil, close_conn: false)
    conn ||= DatabaseConfig.connect

    result = conn.exec_params('SELECT * FROM patients WHERE cpf = $1 LIMIT 1;', [cpf]).entries.first
    
    conn.close if close_conn && conn
    return new(result.transform_keys(&:to_sym)) if result
    nil
  end

  def valid?(conn = nil)
    conn ||= DatabaseConfig.connect

    class_attributes.each do |attr|
      @errors[attr] = 'cannot be empty' if send(attr).nil? || send(attr).empty?
    end

    patient_by_cpf = Patient.find_by_cpf(@cpf, conn)

    @errors[:cpf] = 'must be unique' if patient_by_cpf
    
    @errors.empty?
  end
  
  def class_attributes
    %i[cpf name email birthdate address city state]
  end
end
