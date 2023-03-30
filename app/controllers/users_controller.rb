# frozen_string_literal: true

class UsersController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_user, except: %i[index]
  
  def index
    @pagy, @users = pagy(User.all)
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User updated successfully.'
      redirect_to users_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
