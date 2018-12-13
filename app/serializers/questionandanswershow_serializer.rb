class QuestionandanswershowSerializer < ActiveModel::Serializer
   attributes :title ,:description,:status,:user_id,:answer_id,:created_at,:updated_at
   has_many :answers ,serializer: AnswerSerializer
end