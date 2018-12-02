class UserSerializer < ActiveModel::Serializer
#aca mustro solo los atributos que quiero mostrar cuando llamo a metodos como to_json y as_json
  attributes :username, :password, :screen_name, :email, :token
end
