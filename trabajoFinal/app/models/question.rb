

class Question < ApplicationRecord
 belongs_to :user
 has_many :answers, dependent: :destroy 
 validates_associated :answers
 attribute :status, default: false
 validates_presence_of :title , :description

 
 def self.by_pending_first
 	Question.all.order(status: :asc).order(created_at: :desc)
 end
 
 def self.needing_help
 	Question.all.where(status: 0).order(created_at: :asc)
 end

 def self.natural_order
    Question.all.order(created_at: :desc)
 end 
 
 def tiene_preguntas()
 	return self.answers.count() > 0
 end
end
