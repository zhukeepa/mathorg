class ExplanationsController < ApplicationController
  def new 
    @explanation = Explanation.new
    @explanation.topics = [Topic.find(params[:topic])] unless params[:topic].nil?
  end

  def edit
    @explanation = Explanation.find(params[:id])
  end

  # ::TODO:: test the below code
  def create
    @explanation = Explanation.new(explanation_params)
    @explanation.user = current_user
    @explanation.save

    redirect_to action: :show, id: @explanation.id
  end

  def update
    @explanation = Explanation.find(params[:id])
    @explanation.update(explanation_params)
    @explanation.user = current_user
    @explanation.save

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

private
  def explanation_params
    params[:explanation].permit(:title, :description, :body, :topics_string)
  end
end