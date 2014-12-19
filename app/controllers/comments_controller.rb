class CommentsController < ApplicationController
  def create
  	p = params[:comment]

    @commentable = p[:commentable_type].constantize.find(p[:commentable_id])
    @c = @commentable.comments.create(p.permit(:comment))
    @c.user = current_user
    @c.save

    redirect_to :back
  end
end
