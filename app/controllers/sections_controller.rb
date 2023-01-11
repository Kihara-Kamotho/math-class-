class SectionsController < ApplicationController 
  before_action :set_course, except: [:show, :edit, :update, :destroy] 
  before_action :set_section, only: [:show, :edit, :update, :destroy] 

  def index 
    # display all sections belonging to a course 
    @sections = @course.sections
  end 

  def new 
    @section = @course.sections.new
  end

  def create 
    @section = @course.sections.build(section_params)

    if @section.save
      flash[:notice] = 'Section created successfully.'
      redirect_to section_path @section 
    else 
      render :new 
    end
  end

  def show 
  end

  def edit 
  end 

  def update 
    if @section.update(section_params) 
      flash[:notice] = 'Section updated successfully.' 
      redirect_to section_path(@section) 
    else 
      render :edit 
    end
  end

  def destroy 
    if @section.delete 
      flash[:notice] = 'Section deleted.' 
      redirect_to root_path 
    end 
  end

  private 
  def set_course 
    @course = Course.find(params[:course_id])
  end

  def section_params
    params.require(:section).permit(:title, :description) 
  end

  def set_section 
    @section = Section.find(params[:id])
  end
end