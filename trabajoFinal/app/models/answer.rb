class Answer < ApplicationRecord
 belongs_to :question

 validates_presence_of :question_id, :content, :user_id

 before_destroy :validar_status

#active record colback

private
def validar_status
	throw :abort   if quetion.status 
 
end

end
