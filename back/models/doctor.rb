require_relative '../services/database'

class Doctor
  attr_accessor :id, :crm, :crm_state, :name, :email, :created_at, :updated_at, :errors

  def initialize(params = {})
    @id = params[:id]
    @crm = params[:crm]
    @crm_state = params[:crm_state]
    @name = params[:name]
    @email = params[:email]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @errors = {}
  end

  def self.create(attributes = {}, conn, close_conn: false)
    conn ||= DatabaseConfig.connect
   
    doctor = new(attributes)

    begin
      if doctor.valid?(conn)
        query = "
          INSERT INTO doctors (#{attributes.keys.join(', ')})
          VALUES (#{attributes.values.map.with_index { |values, idx| "$#{idx + 1}"  }.join(', ') })
          RETURNING *;
        "
        result = conn.exec_params(query, attributes.values).entries.first

        doctor = new(result.transform_keys(&:to_sym)) if result
      elsif doctor.errors[:crm_per_state]
        doctor = Doctor.find_by_crm_per_state(attributes[:crm], attributes[:crm_state], conn)
      end
    rescue PG::Error => e
      doctor.errors[:base] = "Error when executing SQL query: #{e.message}"
    ensure
      conn.close if close_conn && conn
    end
    
    doctor
  end

  def self.find_by_crm_per_state(crm, crm_state, conn = nil, close_conn: false)
    conn ||= DatabaseConfig.connect

    result = conn.exec_params('SELECT * FROM doctors WHERE crm = $1 AND crm_state = $2 LIMIT 1;', [crm, crm_state]).entries.first
    
    conn.close if close_conn && con
    return new(result.transform_keys(&:to_sym)) if result
    nil
  end

  def valid?(conn = nil)
    conn ||= DatabaseConfig.connect

    class_attributes.each do |attr|
      @errors[attr] = 'cannot be empty' if send(attr).nil? || send(attr).empty?
    end
    doctor_by_crm = Doctor.find_by_crm_per_state(@crm, @crm_state, conn)

    @errors[:crm_per_state] = 'must be unique per state' if doctor_by_crm

    @errors.empty?
  end

  def class_attributes
    %i[crm crm_state name email]
  end
end
