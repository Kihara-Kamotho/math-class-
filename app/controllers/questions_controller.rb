# frozen_string_literal: true

class QuestionsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_lesson, only: %i[index new create]

  before_action :set_question, except: %i[index new create]

  def index
    @questions = @lesson.questions
  end

  def new
    @question = @lesson.questions.new
  end

  def create
    @question = @lesson.questions.build(question_params)

    respond_to do |format|
      if @question.save
        # turbo_stream
        flash[:notice] = 'Question created successfully.'
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
      if @question.update(question_params)
        flash[:notice] = 'Question updated successfully.'
        format.turbo_stream
      else
        render :edit
      end
    end
  end

  def destroy
    respond_to do |format|
      format.turbo_stream if @question.destroy
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
