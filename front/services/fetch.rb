require 'faraday'

class Fetch
  def self.all
    response = Faraday.get('http://back:3000/tests')
    response.body
  end

  def self.find_by_token(token)
    response = Faraday.get("http://back:3000/tests/#{token.upcase}")
    response.body
  end
end
