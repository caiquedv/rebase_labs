require_relative '../services/database'

class Exam
  attr_accessor :id, :patient_id, :doctor_id, :result_token, :result_date, :created_at, :updated_at, :errors

  def initialize(params = {})
    @id = params[:id]
    @patient_id = params[:patient_id]
    @doctor_id = params[:doctor_id]
    @result_token = params[:result_token]
    @result_date = params[:result_date]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @errors = {}
  end

  def self.create(attributes = {})
    exam = new(attributes)
    conn = DatabaseConfig.connect

    begin
      if exam.valid?(conn)
        query = "
          INSERT INTO exams (#{attributes.keys.join(', ')})
          VALUES (#{attributes.values.map.with_index { |values, idx| "$#{idx + 1}"  }.join(', ') })
          RETURNING *;
        "
        result = conn.exec_params(query, attributes.values).entries.first

        exam = new(result.transform_keys(&:to_sym)) if result
      end
    rescue PG::Error => e
      exam.errors[:base] = "Error when executing SQL query: #{e.message}"
    ensure
      conn.close if conn
    end

    exam
  end

  def self.find_by_token(token, conn = nil)
    conn ||= DatabaseConfig.connect

    result = conn.exec_params('SELECT * FROM exams WHERE result_token = $1 LIMIT 1;', [token]).entries.first
    
    return new(result.transform_keys(&:to_sym)) if result
    nil
  end

  def valid?(conn)
    class_attributes.each do |attr|
      next if attr === :result_date
      @errors[attr] = 'cannot be empty' if send(attr).nil? || send(attr).empty?
    end

    @errors[:result_token] = 'must be unique' if result_token_exists?(conn)

    @errors.empty?
  end

  def class_attributes
    %i[patient_id doctor_id result_token result_date]
  end
  
  private

  def result_token_exists?(conn)
    result = conn.exec_params('SELECT COUNT(*) FROM exams WHERE result_token = $1', [result_token]).getvalue(0, 0).to_i
    result > 0
  end
end
