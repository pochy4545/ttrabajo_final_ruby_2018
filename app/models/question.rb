

class Question < ApplicationRecord
 belongs_to :user
 has_many :answers, dependent: :destroy 
 validates_associated :answers 
 attribute :status, default: false
 validates_presence_of :title , :description
 #"prepend true porque quiero que se ejecute antes de que las answers se destruyan"
 before_destroy :validar_tieneRespuestas, prepend: true
 before_update :validar_respuesta_asociada, if: :validar?
 
 def validar?
 	@validar
 end

 def validar=(op)
 	@validar = op
 end

 def self.by_pending_first
 	all.order(status: :asc).order(created_at: :desc)
 end

 def self.needing_help
 	@questions= where(status: 0)
 	@questions
 	 .left_joins(:answers)
 	 .group(:id)
 	 .order('count(answers.id) desc')

 end

 def self.natural_order
    all.order(created_at: :desc)
 end 
 
 private
 def validar_tieneRespuestas
	throw :abort if answers.count() > 0
 end
 
 def validar_respuesta_asociada
 	throw :abort if ((answers.select {|x| x.id == answer_id}).count() == 0 )
 	
 end
end
