class SubscriptionsController < ApplicationController 
  before_action :set_course, except: [:show, :edit, :update, :destroy] 
  # after_create_commit :pay 

  def index 
  # course_subscriptions
    @subscriptions = @course.subscriptions
  end 

  def new 
    @subscription = @course.subscriptions.new
  end

  def create
    console
    @subscription = @course.subscriptions.build(subscription_params)
    
    if @subscription.save
      # switch subscription to true
      @subscription.update!({ subscribed: true })
      @course.update!({ subscribed: true })
      
      flash[:notice] = "Successfully created subscription." 
      redirect_to course_path @course 
    else
      render :new  
    end 
  end

  def show 
  end 
   
  def edit 
  end 

  def update
  end 

  def destroy
  end 

  private
  def set_course 
    @course = Course.find(params[:course_id])
  end

  def subscription_params
    params.require(:subscription).permit(:user_id, :course_id, :subscribed)
  end
end 