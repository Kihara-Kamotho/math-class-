# To deliver this notification:
#
# SubscriptionNotification.with(post: @post).deliver_later(current_user)
# SubscriptionNotification.with(post: @post).deliver(current_user)

class SubscriptionNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  deliver_by :custom, class: "DeliveryMethods::AfricasTalking"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    # t(".message")
    "Subscribed to course."
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
