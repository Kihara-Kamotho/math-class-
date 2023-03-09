class SubscriptionExpirationReminderJob < ApplicationJob # rubocop:disable Style/Documentation, Style/FrozenStringLiteralComment
  queue_as :default

  def perform
    # list all subscriptions, that are on the verge of expiring
    subscriptions = Subscription.where('expires_at<=?', 3.days.from_now)

    # send notification to each user
    subscriptions.each do |subscription|
      # send notification via noticed
      SubscriptionExpirationReminder.with(subscription:).deliver_later(subscription.user)
    end
  end
end
