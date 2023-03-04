class Lesson < ApplicationRecord
  belongs_to :section
  
  has_many :comments, dependent: :destroy

  has_many :questions

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_one_attached :video 
end
