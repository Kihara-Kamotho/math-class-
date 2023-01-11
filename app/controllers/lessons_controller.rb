class LessonsController < ApplicationController
  before_action :set_section, only: [:index, :new, :create]
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index 
    @lessons = @section.lessons
  end

  def new 
    @lesson = @section.lessons.new
  end

  def create 
    @lesson = @section.lessons.build(lesson_params)

    if @lesson.save 
      flash[:notice] = 'Lesson created successfully.'
      redirect_to lesson_path @lesson 
    else 
      render :new 
    end 
  end

  def show 
    @lesson
    redirect_to lesson_path @lesson 
  end

  def edit 
  end 

  def update 
    if @lesson.update(lesson_params)
      flash[:notice] = 'Lesson updated.'
      redirect_to lesson_path @lesson 
    else 
      render :edit
    end 
  end 

  def destroy 
    if @lesson.delete 
      flash[:notice] = 'Lesson deleted.'
      redirect_to root_path 
    end 
  end 


  private 
  def set_section 
    # lessons are scoped under sections 
    @section = Section.find(params[:section_id])
  end

  def set_lesson 
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description) 
  end
end