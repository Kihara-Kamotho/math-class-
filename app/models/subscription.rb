class Subscription < ApplicationRecord 

  # validations 
  validates :expires_at, presence: true

  # after_create :initialize_payment 
  after_create_commit do 
    # initialize a payment object 
    amount = course.amount
    subscription = Subscription.last
    user = subscription.user
    phone = user.phone
    phone_no = PhonyRails.normalize_number(phone, country_code: 'KE').gsub(/\W/, '') 

    payment = Payment.new(amount: amount, phone: phone_no, subscription_id: subscription.id)
    payment.save!
  end 

  belongs_to :user
  belongs_to :course
  has_one :payment

  # method to check if subscription has expired 
  def expired?
    expires_at < DateTime.now
  end
end