class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @commentable = params[:klass].constantize.find(params[:id])
    @c = @commentable.comments.create(params.permit(:comment))
    @c.user = current_user ##::TODO_LATER:: refactor
    @c.save

    ##::TODO_LATER:: refactor
    if @commentable.respond_to?(:author)
      @commentable.author.notifications << "#{current_user.username} left a comment on your solution to a <a href=\"problems/#{@commentable.problem.id}\">problem</a>."
      @commentable.author.update(notifications: @commentable.author.notifications)
    end

    render partial: 'comments/comment_list', locals: { commentable: @commentable }
  end
end
