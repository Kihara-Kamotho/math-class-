class Subscription < ApplicationRecord 

  # after_create :initialize_payment 
  after_create_commit do 
    # initialize a payment object 
    # amount = course.amount
    @subscription = Subscription.last

    payment = Payment.new(amount: 1, phone: 790911088, subscription_id: @subscription.id)
    payment.save!
  end 

  belongs_to :user
  belongs_to :course
  has_one :payment
end