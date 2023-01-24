class PaymentsController < ApplicationController 
  skip_before_action :verify_authenticity_token
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
      redirect_to root_path, flash => { :notice => "Successfully created payment"}
    else 
      redirect_to root_path, flash => { :alert => "Error creating payment"}
    end 
  end 

  # hit this callback once a payment has been successfully transacted 
  def callback
    merchantrequestID = params[:Body][:stkCallback][:MerchantRequestID]
    checkoutrequestID = params[:Body][:stkCallback][:CheckoutRequestID]

    amount,mpesareceiptnumber,transactiondate,phonenumber=nil
    if params[:Body][:stkCallback][:CallbackMetadata].present?
      params[:Body][:stkCallback][:CallbackMetadata][:Item].each do |item|
        case item[:Name].downcase
        when 'amount'
          amount = item[:Value]
        when 'mpesareceiptnumber'
          mpesareceiptnumber = item[:Value]
        when 'transactiondate'
          transactiondate = item[:Value]
        when 'phonenumber'
          phonenumber = item[:Value]
        end
      end

      pay = Payment.find_by(amount: amount, phone_number: phonenumber, CheckoutRequestID: checkoutrequestID, MerchantRequestID: merchantrequestID)
      pay.state = true
      pay.code = mpesareceiptnumber
      pay.save

      render json: 'received'
    else
      pay = Payment.find_by(CheckoutRequestID: checkoutrequestID, MerchantRequestID: merchantrequestID)
      pay.code = params["Body"]["stkCallback"]["ResultDesc"]
      pay.save
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