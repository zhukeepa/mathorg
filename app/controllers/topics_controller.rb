class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
  end

  def index
  	@topics = Topic.all
  end

  def edit
  	@topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic].permit(:name))
    @parents = Topic.topics_string_to_topics_array(params[:topic][:parents])
    
    # ::TODO:: parents are not getting appropriately added
    #@topic.parents << @parents
    @topic.save
    redirect_to action: :show, id: @topic.id
  end

  def destroy
  	@topic = Topic.find(params[:id])
  	@topic.destroy

  	render text: 'The topic has been destroyed. '
  end
end
