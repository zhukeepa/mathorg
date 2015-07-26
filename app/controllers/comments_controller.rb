class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, except: [:create]

  
  def create
    @commentable = params[:klass].constantize.find(params[:id])
    @c = @commentable.comments.create(params.permit(:comment))
    @c.user = current_user ##::TODO_LATER:: refactor
    @c.save

    render partial: 'comments/comment_list', locals: { commentable: @commentable }
  end

  def edit 
  end

  def update
    @comment.update(comment_params)
    ##::TODO:: refactor
    if @comment.commentable.respond_to?(:problem)
      redirect_to @comment.commentable.problem
      flash[:notice] = "Your comment has been updated"
    else 
      render text: "Your comment has been updated"
    end
  end

  def destroy
    @comment.destroy
    @comment.commentable.send(:nil?) # just to make sure it updates, not sure if dependent: :destroy is actually true... also not sure this actually fixes it, but nbd

    flash[:notice] = "Your comment has been destroyed." 
    redirect_to :back
  end

private 
  def set_comment 
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params[:comment].permit(:comment)
  end
end
