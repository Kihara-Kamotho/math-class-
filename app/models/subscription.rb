# frozen_string_literal: true

class Subscription < ApplicationRecord # rubocop:disable Style/Documentation
  # validations
  validates :expires_at, presence: true

  belongs_to :user
  belongs_to :course
  has_many :payments

  # enum of subscription state
  enum status: { inactive: 0, active: 1 }

  # after_create :initialize_payment
  after_create_commit do |record|
    # initialize a payment object
    user = record.user
    amount = record.course.amount
    phone = user.phone
    phone_no = PhonyRails.normalize_number(phone, country_code: 'KE').gsub(/\W/, '')

    # binding.irb
    payment = Payment.new(amount:, phone: phone_no, subscription_id: record.id)
    payment.save
  end

  # method to check if subscription has expired
  def expired?
    expires_at < DateTime.now
  end
end
