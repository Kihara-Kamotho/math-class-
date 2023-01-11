class CoursesController < ApplicationController 
  before_action :set_course, only: [:show, :edit, :update, :destroy] 

  def index 
    # all courses 
    @courses = Course.all
  end 

  def new 
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save 
      flash[:notice] = 'Course created successfully.'
      redirect_to course_path @course 
    else 
      render :new 
    end
  end

  def show 
    @course 
    redirect_to course_path @course 
  end

  def edit 
  end 

  def update 
    if @course.update(course_params) 
      flash[:notice] = 'Course updated.' 
      redirect_to course_path @course 
    else 
      render :edit 
    end 
  end 

  def destroy 
    if @course.delete 
      flash[:notice] = 'Course deleted.' 
      redirect_to courses_path 
    end 
  end

  private 
  def course_params 
    params.require(:course).permit(:title, :description) 
  end

  def set_course 
    @course = Course.find(params[:id])
  end 
end