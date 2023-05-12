# frozen_string_literal: true

class HomeController < ApplicationController # rubocop:disable Style/Documentation
  before_action :authenticate_user!
  def index
    @courses = Course.all
  end

  def about

  end

  def services

  end

  def contact

  end
end
