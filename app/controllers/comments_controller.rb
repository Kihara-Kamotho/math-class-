class CommentsController < ApplicationController 

  before_action :set_lesson, except: [:show, :edit, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index 
    @comments = @lesson.comments
  end

  def new 
    @comment = @lesson.comments.new
  end

  def create 
    @comment = @lesson.comments.build(comment_params)

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to comment_path(@comment) 
    else 
      render :new 
    end
  end

  def show 
  end

  def edit 
  end 

  def update 
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to comment_path(@comment)  
    else 
      render :edit 
    end 
  end

  def destroy 
    @comment.destroy
    redirect_to root_path 
  end 
  
  private 
  def set_lesson 
    @lesson = Lesson.find(params[:lesson_id])
  end

  def comment_params 
    params.require(:comment).permit(:content, :lesson_id, :user_id)
  end

  def set_comment 
    @comment = Comment.find(params[:id])
  end
end