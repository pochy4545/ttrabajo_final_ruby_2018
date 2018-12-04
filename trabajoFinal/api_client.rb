require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end
 
response = client.post do |req|
  req.url '/users'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "user": {"username":"pochi","password":"mierda4545","screen_name":"poch3223","email":"agustin.c.96@hotmail.com"} }'
end

 
# client here...
 
puts Oj.load(response.body)
puts response.status
