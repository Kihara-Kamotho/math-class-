# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  rolify
  after_create :assign_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_many :courses, through: :subscriptions
  has_many :payments, through: :subscriptions
  has_many :notifications, as: :recepient

  # check if a user is subscribed to a specified course
  def subscribed_to?(course)
    courses.exists?(course.id)
  end

  def assign_default_role
    return unless roles.blank?

    add_role :student
  end
end
