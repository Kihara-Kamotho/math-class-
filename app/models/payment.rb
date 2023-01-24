class Payment < ApplicationRecord 
  belongs_to :subscription
  # after payment is created, initialize stk_push 
  after_create :create_stk_push

  def create_stk_push 
    # hit the mpesa module 
    begin
      response = MpesaStk::PushPayment.call(amount, phone)
      p response

      self.MerchantRequestID = response['MerchantRequestID']
      self.CheckoutRequestID = response['CheckoutRequestID']
      self.response = response
      self.save
    rescue => ex
      p ex.message

      self.response = ex.message
      self.save
    end
  end
end