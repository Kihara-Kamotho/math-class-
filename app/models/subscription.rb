# frozen_string_literal: true

class Subscription < ApplicationRecord # rubocop:disable Style/Documentation
  # validations
  validates :expires_at, presence: true

  belongs_to :user
  belongs_to :course
  has_one :payment

  # enum of subscription state
  enum status: { inactive: 0, active: 1 }

  # after_create :initialize_payment
  after_create_commit do |record|
    # initialize a payment object
    user = record.user
    amount = record.course.amount
    phone = user.phone
    phone_no = PhonyRails.normalize_number(phone, country_code: 'KE').gsub(/\W/, '')

    record.payment.create!(amount:, phone: phone_no)
  end

  # method to check if subscription has expired
  def expired?
    expires_at < DateTime.now
  end
end
