

class Question < ApplicationRecord
 belongs_to :user
 has_many :answers, dependent: :destroy 
 validates_associated :answers
 attribute :status, default: false
 validates_presence_of :title , :description
end
