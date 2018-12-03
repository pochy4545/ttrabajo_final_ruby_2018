require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = client.post do |req|
  req.url '/questions/5/answers'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "question": {"token":"4c49dca58a330ccac9f9e2242110a690","content":"anda" }}'
end


# client here...

puts Oj.load(response.body)
puts response.status


