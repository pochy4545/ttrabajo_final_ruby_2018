require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
question = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = question.post do |req|
  req.url '/questions/6/answers/2'
  req.headers['Content-Type'] = 'application/json'
  req.headers['X-QA-Key'] = "0113e9de4d0f3891d810b877ca26d31e"
  req.body = ''
end


# client here...

puts Oj.load(response.body)
puts response.status



