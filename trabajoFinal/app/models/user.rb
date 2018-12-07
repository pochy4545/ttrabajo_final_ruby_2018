require 'bcrypt'

class User < ApplicationRecord
 include BCrypt
 validates_uniqueness_of :token, :allow_nil => true
 has_many :questions, dependent: :destroy
 validates_associated :questions
 validates_presence_of :username, :password, :screen_name, :email
 validates :username, uniqueness: { message: "username existente"}
 validates :email, uniqueness: { message: "email existente" }
 validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
 
 def self.by_token(token)
 	  where('updated_at <= ?', 30.minutes.ago).update_all(token: nil) 	  
      user=find_by token: token 
      user&.touch
      user
 end


 def existeUsername(username)
      find_by username: username
 end

 def existeEmail(email)
     find_by email: email
 end

 def passworconsulta
     @password ||= Password.new(password)
 end

 def passwordHash=(new_password)
     @password = Password.create(new_password)
     self.password = @password
 end

 def valida_password(password)
    passworconsulta == password
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
