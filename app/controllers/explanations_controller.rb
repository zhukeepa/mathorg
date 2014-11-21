class ExplanationsController < ApplicationController
  def new 
    @explanation = Explanation.new
  end

  def edit
    @explanation = Explanation.find(params[:id])
  end

  def create
    @explanation = Explanation.new(params[:explanation].permit(:title, :description, :body))
    @explanation.user = current_user
    @topics = Topic.topics_string_to_topics_array(params[:explanation][:topics])

    #::CHECK:: is this the best way to implement?
    @explanation.save
    @explanation.topics << @topics


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
end
