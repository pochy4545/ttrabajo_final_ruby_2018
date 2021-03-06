FactoryBot.define do
 factory :user do
 	username {Faker::Name.unique.name}
 	email { Faker::Internet.unique.email}
 	screen_name {'pochy4545'}
 	password {'password'}
 	token { Faker::Number.number(10) }
 	updated_at {Time.new(2001,2,3)}
    
    factory :user_with_questions do
 		transient do 
 			questions_count {2}
 		end

		 	after(:create) do |user, evaluator|
 			create_list(:question,evaluator.questions_count,user: user)
 			end
 	end
 end

 factory :question do
 	title {Faker::Lorem.sentence}
 	description {Faker::Lorem.paragraph}
 	status {false}
 	answer_id {nil}
 	user 

   factory :question_with_answers do
 		transient do
 			answers_count {1}
 		end

 		after(:create) do |question,evaluator|
 			create_list(:answer,evaluator.answers_count,question: question)
 				
 		end
 	end
 end

 factory :answer do
 	content {Faker::Lorem.sentence}
 	question 
 	user 
 end


end