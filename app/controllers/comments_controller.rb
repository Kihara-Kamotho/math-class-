# frozen_string_literal: true

class CommentsController < ApplicationController  # rubocop:disable Style/Documentation
  before_action :set_lesson, except: %i[show edit update destroy]

  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = @lesson.comments
  end

  def new
    @comment = @lesson.comments.new
  end

  def create
    @comment = @lesson.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to redirect_to comment_path(@comment), flash[:notice] = 'Comment was successfully created.'}
      else
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream
        format.html { redirect_to comment_path(@comment), flash[:notice] = 'Comment was successfully updated.' }
      else
        render :edit
      end
    end
  end

  def destroy
    respond_to do |format|
      format.turbo_stream if @comment.destroy
    end
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
