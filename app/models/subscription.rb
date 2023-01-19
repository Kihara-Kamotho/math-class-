class Subscription < ApplicationRecord 
  belongs_to :user
  belongs_to :course


  # subscribe course 
  # @subscription  
end