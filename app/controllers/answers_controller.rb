# frozen_string_literal: true

class AnswersController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_question, only: %i[index new create]

  before_action :set_answer, except: %i[index new create]

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.build(answer_params)

    respond_to do |format|
      if @answer.save
        # turbo_stream
        format.turbo_stream
      else
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
