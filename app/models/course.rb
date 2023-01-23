class Course < ApplicationRecord
  has_many :sections 
  has_many :lessons, through: :sections 
  has_many :subscriptions
  has_many :payments, through: :subscriptions 
  
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
