class ExplanationsController < ApplicationController
  def new 
    @explanation = Explanation.new
    @explanation.topics = [Topic.find(params[:topic])] unless params[:topic].nil?
    @explanation.body = RichText.new
  end

  def edit
    @explanation = Explanation.find(params[:id])
  end

  def create
    #::TODO:: maybe there's a more succint way? or maybe this is alright as is...
    @explanation = Explanation.new(explanation_params)
    @explanation.body = RichText.new(body_params)
    @explanation.save

    redirect_to action: :show, id: @explanation.id
  end

  def update
    @explanation = Explanation.find(params[:id])
    @explanation.update(explanation_params)
    @explanation.body.update(body_params)

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
    params[:explanation].permit(:title, :description, :body_attributes, :topics_string)
  end

  def body_params
    params[:explanation][:rich_text].permit(:text)
  end
end