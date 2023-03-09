class MpesaPaymentJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # After payment has been successfully made, change state to active
  end
end
