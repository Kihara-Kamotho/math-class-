# frozen_string_literal: true

class LessonsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_section, only: %i[index new create]
  before_action :set_lesson, only: %i[show edit update destroy]

  def index
    @pagy, @lessons = pagy(@section.lessons, items: 3)
  end

  def new
    @lesson = @section.lessons.new
  end

  def create
    @lesson = @section.lessons.build(lesson_params)

    respond_to do |format|
      if @lesson.save
        flash[:notice] = 'Lesson created successfully.'
        format.html { redirect_to lesson_path @lesson }
        format.turbo_stream
      else
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        flash[:notice] = 'Lesson updated.'
        format.html { redirect_to lesson_path @lesson }
        format.turbo_stream
      else
        render :edit
      end
    end
  end

  def destroy
    return unless @lesson.delete

    flash[:notice] = 'Lesson deleted.'
    redirect_to root_path
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
    params.require(:lesson).permit(:title, :description, :video)
  end
end
