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

  def self.create(attributes = {})
    patient = new(attributes)
    conn = DatabaseConfig.connect

    begin
      if patient.valid?(conn)
        query = "
          INSERT INTO patients (#{attributes.keys.join(', ')})
          VALUES (#{attributes.values.map.with_index { |values, idx| "$#{idx + 1}"  }.join(', ') })
          RETURNING *;
        "
        result = conn.exec_params(query, attributes.values).entries.first

        patient = new(result.transform_keys(&:to_sym)) if result
      end
    rescue PG::Error => e
      patient.errors[:base] = "Error when executing SQL query: #{e.message}"
    ensure
      conn.close if conn
    end

    patient
  end

  def valid?(conn)
    class_attributes.each do |attr|
      @errors[attr] = 'cannot be empty' if send(attr).nil? || send(attr).empty?
    end

    @errors[:cpf] = 'must be unique' if cpf_exists?(@cpf, conn)
    
    @errors.empty?
  end

  private

  def class_attributes
    %i[cpf name birthdate address city state]
  end

  def cpf_exists?(cpf, conn)
    result = conn.exec_params('SELECT COUNT(*) FROM patients WHERE cpf = $1', [cpf]).getvalue(0, 0).to_i
    result > 0
  end
end
