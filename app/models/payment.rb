# frozen_string_literal: true

class Payment < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :subscription
  # after payment is created, initialize stk_push
  after_create :create_stk_push

  def create_stk_push
    # hit the mpesa module
    response = MpesaStk::PushPayment.call(amount, phone)
    p response

    self.MerchantRequestID = response['MerchantRequestID']
    self.CheckoutRequestID = response['CheckoutRequestID']
    self.response = response
    save
  end
end
