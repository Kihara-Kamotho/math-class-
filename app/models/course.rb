class Course < ApplicationRecord
  has_many :sections 
  has_many :lessons, through: :sections 

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
