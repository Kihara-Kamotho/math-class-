# frozen_string_literal: true

class SubscriptionsController < ApplicationController  # rubocop:disable Style/Documentation
  before_action :set_course, except: %i[show edit update destroy all_subscriptions]
  # after_create_commit :pay
  def all_subscriptions
    @subscriptions = Subscription.all
  end

  def index
    # course_subscriptions
    @subscriptions = @course.subscriptions
  end

  def new
    @subscription = @course.subscriptions.new
  end

  def create
    # console
    @subscription = @course.subscriptions.build(subscription_params)
    @subscription.expires_at = DateTime.now + 1.month

    if @subscription.save
      # send notification
      @user = current_user
      # SubscriptionNotification.with(@subscription).deliver_later(@user)

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
