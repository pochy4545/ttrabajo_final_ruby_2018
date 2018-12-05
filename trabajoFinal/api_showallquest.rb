require 'faraday'
require 'oj'

#uso interno para generar una consulta post insertando un usuario 
question = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = question.get do |req|
  req.url '/questions'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "data": {"type":"questions","attributes":{"sort":"needing_help"}}}'
end


# client here...

puts Oj.load(response.body)
puts response.status

