class QuestionSerializer < ActiveModel::Serializer
#aca mustro solo los atributos que quiero mostrar cuando llamo a metodos como to_json y as_json
  #attributes :id,:title,:description,:user_id, :created_at, :status
  #belongs_to :user
  #has_many :answers
end
