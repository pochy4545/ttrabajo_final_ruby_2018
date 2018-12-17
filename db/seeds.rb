# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


 c1 = User.create(username: "genetfirst",email: "genetest1@example.com", password: "1234", screen_name: "genetestfirst" , token: nil)
 c2 = User.create(username: "genesecond",email: "genetest2@example.com", password: "1234", screen_name: "genetestsecond", token: nil)
 
 q1 = Question.create( title: "genetest1", description:"undefined1", status:false, answer_id: nil, user_id: c1.id )
 q2 = Question.create( title: "genetest2", description:"undefined2", status:false, answer_id: nil, user_id: c2.id )

4.times do |i|
 a1 = Answer.create( content: "genetest#{i}" , question_id: q1.id , user_id: c1.id)
end