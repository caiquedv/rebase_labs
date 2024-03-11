require_relative '../services/database'

class Test
  attr_accessor :id, :exam_id, :type, :limits, :results, :created_at, :updated_at, :errors

  def initialize(params = {})
    @id = params[:id]
    @exam_id = params[:exam_id]
    @type = params[:type]
    @limits = params[:limits]
    @results = params[:results]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @errors = {}
  end

  def self.create(attributes = {}, conn, close_conn: false)
    test = new(attributes)
    conn ||= DatabaseConfig.connect

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
      conn.close if close_conn && conn
    end

    test
  end

  def valid?(conn)
    class_attributes.each do |attr|
      next if attr === :results
      @errors[attr] = 'cannot be empty' if send(attr).nil? || send(attr).empty?
    end

    @errors.empty?
  end

  def class_attributes
    %i[exam_id type limits results]
  end
end
