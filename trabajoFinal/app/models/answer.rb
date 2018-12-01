class Answer < ApplicationRecord
 belongs_to :question

 validates_presence_of :question_id, :content, :user_id
end
