# rubocop:disable Style/Documentation
# To deliver this notification:
#
# SubscriptionExpirationReminder.with(post: @post).deliver_later(current_user)
# SubscriptionExpirationReminder.with(post: @post).deliver(current_user)

class SubscriptionExpirationReminder < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  deliver_by :custom, class: 'DeliveryMethods::AfricasTalking'

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    # t(".message")
    "Your subscription #{params[:subscription]} is due to a expire on #{params[:subscription.expires_at]}"
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end

# rubocop:enable Style/Documentation
