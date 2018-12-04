require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = client.post do |req|
  req.url '/sessions'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "data": {"type":"users","attributes":{"username": "pochi","password":"mierda4545"} }}'
end


# client here...

puts Oj.load(response.body)
puts response.status

