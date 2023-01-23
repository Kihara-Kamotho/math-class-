class PaymentsController < ApplicationController 
  before_action :set_subscription

  def index 
    @payments = Payment.all
  end 

  def new 
    @payment = @subscription.payment.new
  end

  def create
    @payment = @subscription.payment.new(payment_params)

    if @payment.save
      flash[:notice] = "Successfully created payment." 
      redirect_to root_path 
    end 
  end 

  private 
  def set_subscription 
    @subscription = Subscription.find(params[:subscription_id])
  end 

  def payment_params 
    params.require(:payment).permit(:amount, :phone, :subscription_id)
  end
end 