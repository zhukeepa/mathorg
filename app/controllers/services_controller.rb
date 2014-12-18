class ServicesController < ApplicationController
  def preview
    render json: { preview_html: params[:text].bbcode_to_html.gsub("\n", "<br/>") }
  end

  def vote
    klass = params[:klass].constantize
    e = klass.find(params[:id])
    e.vote_by voter: current_user, vote: params[:vote]

    respond_to do |format|
      format.html
      format.js { render: '/app/views/shared/vote' }#, locals: { upvote_num: e.get_upvotes.size, downvote_num: e.get_downvotes.size } }
    end
  end
end
