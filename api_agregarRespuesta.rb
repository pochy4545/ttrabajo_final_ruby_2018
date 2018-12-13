require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = client.post do |req|
  req.url '/questions/6/answers'
  req.headers['Content-Type'] = 'application/json'
  req.headers["X-QA-Key"]='f66a41e0c2aa1d8c187819f9e9330d5a'
  req.body = '{"content":"respuesta uno" }'
end


# client here...

puts Oj.load(response.body)
puts response.status


