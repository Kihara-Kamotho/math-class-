# frozen_string_literal: true

class Course < ApplicationRecord # rubocop:disable Style/Documentation
  has_many :sections
  has_many :lessons, through: :sections
  has_many :subscriptions
  has_many :payments, through: :subscriptions

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  # turbo stream & action cable

  after_create_commit lambda {
                        broadcast_append_to 'courses', partial: 'courses/course',
                                                       locals: { course: self }, target: 'courses'
                      }
  after_update_commit -> { broadcast_replace_to 'courses' }

  after_destroy_commit -> { broadcast_remove_to 'courses' }

  def self.ransackable_attributes(auth_object = nil) # rubocop:disable Lint/UnusedMethodArgument
    %w[amount created_at description id subscribed title updated_at]
  end
end
