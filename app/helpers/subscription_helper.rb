module SubscriptionHelper # rubocop:disable Style/Documentation, Style/FrozenStringLiteralComment
  def active_subscription?(user, course)
    subscription = Subscription.find_by(user_id: user.id, course_id: course.id)
    subscription.present? && subscription.active?
  end
end
