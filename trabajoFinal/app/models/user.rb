require 'bcrypt'

class User < ApplicationRecord
 include BCrypt
 has_many :questions, dependent: :destroy
 validates_presence_of :username, :password, :screen_name, :email
 

 

 def passworconsulta
     @password ||= Password.new(password)
 end

 def passwordHash=(new_password)
     @password = Password.create(new_password)
     self.password = @password
 end

 
  
 # generate_token creará un token en un ciclo interminable y revisará si
 #es único o no. Tan pronto como un token único sea encontrado, regrésalo:
 def generate_token
     loop do
       token = SecureRandom.hex
       return token unless User.exists?({token: token})
     end
 end
 
end
