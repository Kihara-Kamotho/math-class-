# frozen_string_literal: true

class HomeController < ApplicationController # rubocop:disable Style/Documentation
  def index
    @courses = Course.all
  end
end
