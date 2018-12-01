class User < ApplicationRecord
 has_many :questions, dependent: :destroy
 validates_presence_of :username, :password, :screen_name, :email
end
