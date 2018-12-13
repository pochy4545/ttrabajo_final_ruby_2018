class AnswerSerializer < ActiveModel::Serializer
   attributes :content,:created_at,:updated_at ,:user_id
   

  end