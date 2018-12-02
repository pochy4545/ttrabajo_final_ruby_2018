class Question < ApplicationRecord
 belongs_to :user
 has_many :answers, dependent: :destroy 
 attribute :status, default: false
 validates_presence_of :title , :description
end
