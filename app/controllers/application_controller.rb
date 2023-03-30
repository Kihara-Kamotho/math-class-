class ApplicationController < ActionController::Base
  before_action :authorize

  include Pundit::Authorization
  
  include Pagy::Backend
  include SubscriptionHelper

  protected
  
  def authorize
    authenticate_user!
  end
end
