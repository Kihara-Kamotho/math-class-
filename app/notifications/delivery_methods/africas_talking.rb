class DeliveryMethods::AfricasTalking < Noticed::DeliveryMethods::Base 

  def deliver
    # Logic for sending the notification
    AfricasTalking::SmsClient.new(phone: [recipient.phone], message: notification.message).send
  end
end 
