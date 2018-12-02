class User < ApplicationRecord
 has_many :questions, dependent: :destroy
 validates_presence_of :username, :password, :screen_name, :email
 #se usa despues de un User.create y al mismo objeto le asigna lo que devuelve la funcion generate token
 before_create -> {self.token = generate_token}

 private
  
 # generate_token creará un token en un ciclo interminable y revisará si
 #es único o no. Tan pronto como un token único sea encontrado, regrésalo:
 def generate_token
     loop do
       token = SecureRandom.hex
       return token unless User.exists?({token: token})
     end
 end
 
end
