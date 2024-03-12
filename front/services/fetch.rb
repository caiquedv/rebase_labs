require 'faraday'

class Fetch
  def self.all
    response = Faraday.get('http://back:3000/tests')
    response.body
  end
end
