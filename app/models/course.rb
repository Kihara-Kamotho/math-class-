class Course < ApplicationRecord
  has_many :sections 
  has_many :lessons, through: :sections 
  has_many :subscriptions
  has_many :payments, through: :subscriptions 
  
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "description", "id", "subscribed", "title", "updated_at"]
  end
end
