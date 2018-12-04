require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = client.post do |req|
  req.url '/questions/6/answers'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "question": {"token":"6da9edab9df1eecf5bf5d2677b1acfdc","content":"respuesta uno" }}'
end


# client here...

puts Oj.load(response.body)
puts response.status


