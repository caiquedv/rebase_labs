require_relative '../services/database'

class Test
  attr_accessor :id, :exam_id, :test_type, :test_type_limits, :test_type_results, :created_at, :updated_at, :errors

  def initialize(params = {})
    @id = params[:id]
    @exam_id = params[:exam_id]
    @test_type = params[:test_type]
    @test_type_limits = params[:test_type_limits]
    @test_type_results = params[:test_type_results]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @errors = {}
  end

  def self.create(attributes = {})
    test = new(attributes)
    conn = DatabaseConfig.connect

    begin
      if test.valid?(conn)
        query = "
          INSERT INTO tests (#{attributes.keys.join(', ')})
          VALUES (#{attributes.values.map.with_index { |values, idx| "$#{idx + 1}"  }.join(', ') })
          RETURNING *;
        "
        result = conn.exec_params(query, attributes.values).entries.first

        test = new(result.transform_keys(&:to_sym)) if result
      end
    rescue PG::Error => e
      test.errors[:base] = "Error when executing SQL query: #{e.message}"
    ensure
      conn.close if conn
    end

    test
  end

  def valid?(conn)
    class_attributes.each do |attr|
      next if attr === :test_type_results
      @errors[attr] = 'cannot be empty' if send(attr).nil? || send(attr).empty?
    end

    @errors.empty?
  end

  private

  def class_attributes
    %i[exam_id test_type test_type_limits test_type_results]
  end
end
