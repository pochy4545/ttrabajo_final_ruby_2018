class Question < ApplicationRecord
 belongs_to :user
 has_many :answers, dependent: :destroy 

 validates_presence_of :title , :description, :status ; :user_id 
end
