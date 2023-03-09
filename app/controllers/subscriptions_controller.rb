# frozen_string_literal: true

class SubscriptionsController < ApplicationController  # rubocop:disable Style/Documentation
  before_action :set_course, except: %i[show edit update destroy]
  # after_create_commit :pay

  def index
    # course_subscriptions
    @subscriptions = @course.subscriptions
  end

  def new
    @subscription = @course.subscriptions.new
  end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    # console
    @subscription = @course.subscriptions.build(subscription_params)
    @subscription.expires_at = DateTime.now + 1.month

    if @subscription.save
      # send notification
      SubscriptionNotification.with(subsription: @subscription).deliver_later(current_user)

      # switch subscription to true
      @subscription.update!({ subscribed: true })
      @course.update!({ subscribed: true })

      flash[:notice] = 'Successfully created subscription.'
      redirect_to course_path @course
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def subscription_params
    params.require(:subscription).permit(:user_id, :course_id, :subscribed, :status)
  end
end
