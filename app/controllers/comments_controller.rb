class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @commentable = params[:klass].constantize.find(params[:id])
    @c = @commentable.comments.create(params.permit(:comment))
    @c.user = current_user ##::TODO_LATER:: refactor
    @c.save

    if @commentable.kind_of?(Solution) && @commentable.author != current_user
      @commentable.author.notify!(:solution_comment, current_user, @commentable)
    end

    render partial: 'comments/comment_list', locals: { commentable: @commentable }
  end
end
