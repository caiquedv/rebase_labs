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

  def self.create(attributes = {})
    doctor = new(attributes)
    conn = DatabaseConfig.connect

    begin
      if doctor.valid?(conn)
        query = "
          INSERT INTO doctors (#{attributes.keys.join(', ')})
          VALUES (#{attributes.values.map.with_index { |values, idx| "$#{idx + 1}"  }.join(', ') })
          RETURNING *;
        "
        result = conn.exec_params(query, attributes.values).entries.first

        doctor = new(result.transform_keys(&:to_sym)) if result
      end
    rescue PG::Error => e
      doctor.errors[:base] = "Error when executing SQL query: #{e.message}"
    ensure
      conn.close if conn
    end

    doctor
  end

  def self.find_by_crm_per_state(crm, crm_state, conn = nil)
    conn ||= DatabaseConfig.connect

    result = conn.exec_params('SELECT * FROM doctors WHERE crm = $1 AND crm_state = $2 LIMIT 1;', [crm, crm_state]).entries.first
    
    return new(result.transform_keys(&:to_sym)) if result
    nil
  end

  def valid?(conn)
    class_attributes.each do |attr|
      @errors[attr] = 'cannot be empty' if send(attr).nil? || send(attr).empty?
    end

    @errors[:crm] = 'must be unique per state' if crm_exists?(conn)

    @errors.empty?
  end

  def class_attributes
    %i[crm crm_state name email]
  end

  private

  def crm_exists?(conn)
    result = conn.exec_params('SELECT COUNT(*) FROM doctors WHERE crm = $1 AND crm_state = $2', [crm, crm_state]).getvalue(0, 0).to_i
    result > 0
  end
end
