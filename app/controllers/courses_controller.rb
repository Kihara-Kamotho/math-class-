# frozen_string_literal: true

class CoursesController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_course, only: %i[show edit update destroy]

  def index
    # all courses
    @courses = Course.all.includes(:sections)
    @q = Course.ransack(params[:q])
    @pagy, @courses = pagy(@q.result(distinct: true), items: 7)
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        flash[:notice] = 'Course created successfully.'
        format.turbo_stream
        format.html { redirect_to course_path @course }
      else
        render :new
      end
    end
  end

  def show
    authorize @course
  end

  def edit
    authorize @course
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        flash[:notice] = 'Course updated.'
        format.turbo_stream
        format.html { redirect_to course_path @course }
      else
        render :edit
      end
    end
  end

  def destroy
    respond_to do |format|
      authorize @course

      if @course.delete
        flash[:notice] = 'Course deleted.'
        format.html { redirect_to courses_path }
        format.turbo_stream
      end
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :amount)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
