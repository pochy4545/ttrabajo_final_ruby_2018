require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
question = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = question.post do |req|
  req.url '/questions'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "question": {"title": "test","description":"m","token":"4c49dca58a330ccac9f9e2242110a690"} }'
end


# client here...

puts Oj.load(response.body)
puts response.status


