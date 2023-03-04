class QuestionsController < ApplicationController 

  before_action :set_lesson, only: [:index, :new, :create] 

  before_action :set_question, except: [:index, :new, :create]

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
        format.turbo_stream 
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
  end 

  def destroy 
    if @question.destroy 
      # turbo_stream 
    end 
  end 

  private 
  def set_lesson 
    @lesson = Lesson.find_by(params[:lesson_id])
  end

  def question_params 
    params.require(:question).permit(:title, :body) 
  end 

  def set_question 
    @question = Question.find(params[:id])
  end
end
