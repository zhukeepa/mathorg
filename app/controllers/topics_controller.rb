class TopicsController < ApplicationController
  autocomplete :topic, :name
  def show
    @topic = Topic.find(params[:id])
  end

  def index
  	@topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def edit
  	@topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic].permit(:name))
    @parents = Topic.topics_string_to_topics_array(params[:topic][:parents])
    @topic.parents = @parents
    @topic.save

    redirect_to action: :show, id: @topic.id
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(params[:topic].permit(:name))
    @parents = Topic.topics_string_to_topics_array(params[:topic][:parents])
    @topic.parents  = @parents

    redirect_to @topic
  end

  def destroy
  	@topic = Topic.find(params[:id])
  	@topic.destroy

  	render text: 'The topic has been destroyed. '
  end
end
