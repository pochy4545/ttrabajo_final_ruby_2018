class QuestionshowallSerializer < ActiveModel::Serializer
  attributes :title,:description,:status,:cantidadDeRespuestas
  def cantidadDeRespuestas
  	@object.answers.count()
  end
  def description
    if @object.description.size > 120
    	return @object.description[0..120]+"..."
    else
       return @object.description	
  end
  end
end