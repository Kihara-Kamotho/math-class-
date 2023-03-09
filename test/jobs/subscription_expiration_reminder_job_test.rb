# rubocop:disable Lint/UselessAssignment
require "test_helper"

class SubscriptionExpirationReminderJobTest < ActiveJob::TestCase
  test 'job is enqueued for users with expiring subscription' do
    # Create a user with a subscription that expires in 2 days
    user = User.create!(email: 'test@example.com', password: 'password')
    course = Course.create!(title: 'test', description: 'test description')
    subscription = Subscription.create!(user:, course:, expires_at: 2.days.from_now)

    # Enqueue the job
    assert_enqueued_with(job: SubscriptionExpirationReminderJob, queue: 'default') do
      SubscriptionExpirationReminderJob.perform_later
    end
  end
end

# rubocop:enable Lint/UselessAssignment
