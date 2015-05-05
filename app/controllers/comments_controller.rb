class CommentsController < ApplicationController
  def create
    @commentable = params[:klass].constantize.find(params[:id])
    @c = @commentable.comments.create(params.permit(:comment))
    @c.user = current_user
    @c.save

    render partial: 'comments/comment_list', locals: { commentable: @commentable }
  end
end
