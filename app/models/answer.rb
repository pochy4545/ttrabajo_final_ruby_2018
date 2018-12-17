class Answer < ApplicationRecord
 belongs_to :question
 belongs_to :user
 validates_presence_of :question_id, :content, :user_id

 before_destroy :validar_respuesta
 before_save :validar_status

private
def validar_status
	throw :abort   if question.status == 1 
 
end

def validar_respuesta
	throw :abort if question.answer_id == id

end
end
