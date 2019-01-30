require 'bcrypt'

class User < ApplicationRecord
 include BCrypt
 validates_uniqueness_of :token, :allow_nil => true
 has_many :questions, dependent: :destroy
 validates_associated :questions
 validates_presence_of :username,  :screen_name, :email ,:password
 validates :username, uniqueness: true
 validates :email, uniqueness: true
 validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
 def self.by_token(token)
 	  where('updated_at <= ?', 30.minutes.ago).update_all(token: nil) 	  
      user=find_by token: token 
      user&.touch
      user
 end


 def existe_username(username)
      find_by username: username
 end

 def existe_email(email)
     find_by email: email
 end

 def passwor_consulta
     @password ||= Password.new(password)
 end

 def password_hash=(new_password)
   unless new_password.blank?
     @password = Password.create(new_password)
     self.password = @password
    else return false
    end
 end

 def valida_password(password)
    passwor_consulta == password
 end
  
 def generate_token
    loop do
      token = SecureRandom.hex
      return token unless User.exists?({token: token})
    end
 end
end
