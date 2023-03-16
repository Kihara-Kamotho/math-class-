class ApplicationController < ActionController::Base
  before_action :authorize

  include Pagy::Backend
  include SubscriptionHelper

  protected
  
  def authorize
    authenticate_user!
  end
end
