require_relative 'database'

class TestService
  def self.parse_tests
    conn = DatabaseConfig.connect
    result = conn.exec("
      SELECT
        e.result_token AS result_token,
        e.result_date AS result_date,
        jsonb_build_object(
          'cpf', p.cpf,
          'name', p.name,
          'email', p.email,
          'birthdate', p.birthdate,
          'address', p.address,
          'city', p.city,
          'state', p.state
        ) AS patient,
        jsonb_build_object(
          'crm', d.crm,
          'name', d.name,
          'email', d.email,
          'crm_state', d.crm_state
        ) AS doctor,
        jsonb_agg(
          jsonb_build_object(
            'test_type', t.test_type,
            'test_type_limits', t.test_type_limits,
            'test_type_results', t.test_type_results
          )
        ) AS tests
      FROM
        exams e
      JOIN
        patients p ON e.patient_id = p.id
      JOIN
        doctors d ON e.doctor_id = d.id
      LEFT JOIN
        tests t ON e.id = t.exam_id
      GROUP BY
        e.id, p.id, d.id
      ORDER BY
        e.id;
    ")

    conn.close

    formatted_results = result.map do |entry|
      {
        "result_token": entry['result_token'],
        "result_date": entry['result_date'],
        "patient": JSON.parse(entry['patient']),
        "doctor": JSON.parse(entry['doctor']),
        "tests": JSON.parse(entry['tests'])
      }
    end

    formatted_results.to_json
  end
end
