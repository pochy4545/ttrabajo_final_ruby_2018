FactoryBot.define do
 factory :user do
 	username {'agustin'}
 	email { Faker::Internet.unique.email}
 	screen_name {'pochy4545'}
 	password {'password'}
 	token { Faker::Number.number(10) }

 	transient do 
 		questions_count {1}
 	end

 	after(:create) do |user, evaluator|
 		create_list(
 			:question,
 			evaluator.questions_count,
 			user: user
 			)
 	end
 end

 factory :question do
 	title {Faker::Lorem.setence}
 	description {Faker::Lorem.paragraph}
 	status {false}
 	answer {factory :answer}
 	user {factory :user}

 	transient do
 		answer_count {2}
 	end

 	after(:create) do |question,evaluator|
 		create_list(
 			:answer,
 			evaluator.answer_count,
 			question: question
 			)
 	end
 end

 factory :answer do
 	content {Faker::Lorem.sentence}
 	question {factory :question}
 	user {factory :user}
 end
end