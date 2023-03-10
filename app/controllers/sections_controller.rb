# frozen_string_literal: true

class SectionsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_course, except: %i[show edit update destroy]

  before_action :set_section, only: %i[show edit update destroy]

  def index
    # display all sections belonging to a course
    @pagy, @sections = pagy(subscribed_course.sections, items: 3)
  end

  def new
    @section = @course.sections.new
  end

  def create
    @section = @course.sections.build(section_params)

    respond_to do |format|
      if @section.save
        format.turbo_stream
        format.html { redirect_to section_path(@section), flash[:notice] = 'Section created successfully.' }
      else
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to section_path(@section), flash[:notice] = 'Section updated successfully.' }
        format.turbo_stream
      else
        render :edit
      end
    end
  end

  def destroy
    return unless @section.delete

    flash[:notice] = 'Section deleted.'
    redirect_to root_path
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

  def subscribed_course
    current_user.subscriptions.find_by(course_id: params[:course_id])&.course
  end
end
