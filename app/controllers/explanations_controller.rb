class ExplanationsController < ApplicationController
  def new 
    @explanation = Explanation.new
    @explanation.topics = [Topic.find(params[:topic])] unless params[:topic].nil?
  end

  def edit
    @explanation = Explanation.find(params[:id])
  end

  def create
    @explanation = Explanation.new(params[:explanation].permit(:title, :description, :body))
    @explanation.user = current_user
    @topics = Topic.topics_string_to_topics_array(params[:explanation][:topics])

    @explanation.topics = @topics
    @explanation.save

    redirect_to action: :show, id: @explanation.id
  end

  def update
    @explanation = Explanation.find(params[:id])
    @explanation.user = current_user
    @topics = Topic.topics_string_to_topics_array(params[:explanation][:topics])
    
    @explanation.update(params[:explanation].permit(:title, :description, :body))
    @explanation.topics = @topics

    redirect_to @explanation
  end

  def show
    @explanation = Explanation.find(params[:id])
  end

  def destroy
      @explanation = Explanation.find(params[:id])
      @explanation.destroy

      render text: 'Your explanation has been deleted.'
  end

  def vote
    e = Explanation.find(params[:id])
    e.vote_by voter: current_user, vote: params[:vote]

    respond_to do |format|
      format.html
      format.js { render 'vote', locals: { upvote_num: e.get_upvotes.size, downvote_num: e.get_downvotes.size } }
    end
  end
end