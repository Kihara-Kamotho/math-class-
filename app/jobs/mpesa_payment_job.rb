class MpesaPaymentJob < ApplicationJob # rubocop:disable Style/Documentation
  queue_as :default

  def perform(subscription_id)
    # After payment has been successfully made, change state to active
    subscription = Subscription.find(subscription_id:)
    # payment processing
    # if subscription payment has state true & code is not nil, then payment processing has been successful
    if subscription.payment.state? && !subscription.payment.code.nil?
      subscription.update(status: 'active')
      # send notification
    else
      # Retry the job in case of any errors or failures
      retry_job wait: 5.minutes, queue: :low_priority
    end
  end
end
