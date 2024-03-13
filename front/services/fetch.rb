require 'faraday'
require 'faraday/multipart'

class Fetch
  def self.all
    response = Faraday.get('http://back:3000/tests')
    response.body
  end

  def self.find_by_token(token)
    response = Faraday.get("http://back:3000/tests/#{token.upcase}")
    response.body
  end

  def self.import_csv(csvFile)
    f_connection = Faraday.new(url: 'http://back:3000') do |f|
      f.request :multipart
      f.request :url_encoded
      f.adapter Faraday.default_adapter
    end

    params = { file: Faraday::Multipart::FilePart.new(csvFile, 'text/csv') }

    api_response = f_connection.post('/import', params)

    api_response.body
  end
end
