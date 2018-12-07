class Answer < ApplicationRecord
 belongs_to :question
 belongs_to :user
 validates_presence_of :question_id, :content, :user_id

 before_destroy :validar_respuesta
 before_save :validar_status
#active record colback

private
def validar_status
	throw :abort   if !question.status 
 
end
#mirar
def valida_respuesta
	throw :abort if question.id == answer.id

end
