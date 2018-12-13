require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
question = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = question.delete do |req|
  req.url '/questions/6/answers/3'
  req.headers['Content-Type'] = 'application/json'
  req.headers['X-QA-Key'] = "0213a348d05a0cc9e9c2c537308dcc44"
  req.body = '{"content":"test2"}'
end


# client here...

puts Oj.load(response.body)
puts response.status



