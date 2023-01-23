class Subscription < ApplicationRecord 

  # after_create :initialize_payment 
  after_create_commit do 
    # initialize a payment object 
    amount = course.amount
    subscription = Subscription.last
    user = subscription.user
    phone = user.phone

    payment = Payment.new(amount: amount, phone: phone, subscription_id: subscription.id)
    payment.save!
  end 

  belongs_to :user
  belongs_to :course
  has_one :payment
end