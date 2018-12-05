class QuestionshowallSerializer < ActiveModel::Serializer
#aca mustro solo los atributos que quiero mostrar cuando llamo a metodos como to_json y as_json
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