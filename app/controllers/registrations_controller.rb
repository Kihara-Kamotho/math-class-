# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController  # rubocop:disable Style/Documentation
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone)
  end
end
