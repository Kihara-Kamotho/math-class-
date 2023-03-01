class CoursesController < ApplicationController 
  before_action :set_course, only: [:show, :edit, :update, :destroy] 

  def index 
    # all courses 
    @courses = Course.all.includes(:sections)
    @q = Course.ransack(params[:q])
    @pagy, @courses = pagy(@q.result(distinct: true), items: 7)
  
  end 

  def new 
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|

      if @course.save 
        format.turbo_stream
        format.html { redirect_to course_path @course, flash[:notice] = 'Course created successfully.'} 
      else 
        render :new 
      end
    end
  end

  def show 
  end

  def edit 
  end 

  def update 
    respond_to do |format| 

      if @course.update(course_params) 
        format.turbo_stream 
        format.html { redirect_to course_path @course, flash[:notice] = 'Course updated.' } 
      else 
        render :edit 
      end 
    end 
  end 

  def destroy 
    respond_to do |format|  

      if @course.delete 
        format.html { redirect_to courses_path, flash[:notice] = 'Course deleted.' }  
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
