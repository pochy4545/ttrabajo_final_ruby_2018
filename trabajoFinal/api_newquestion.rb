require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
question = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = question.post do |req|
  req.url '/questions'
  req.headers['Content-Type'] = 'application/json'
  req.headers['X-QA-Key'] = "9423e6d6e670b7ea753688f7ff1a4dae"
  req.body = '{ "data": {"type":"questions","attributes":{ "title": "test","description":"sasas"} }}'
end


# client here...

puts Oj.load(response.body)
puts response.status


