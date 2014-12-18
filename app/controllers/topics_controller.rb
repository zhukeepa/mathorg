class TopicsController < ApplicationController
  autocomplete :topic, :name

  def show
    @topic = Topic.find(params[:id])
  end

  def index
  	@root_topics = Topic.all.keep_if { |t| t.parents.size == 0 }
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
    
    if @topic.save
      redirect_to action: :show, id: @topic.id
    else
      render 'new'
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(params[:topic].permit(:name))
      @parents = Topic.topics_string_to_topics_array(params[:topic][:parents])
      @topic.parents  = @parents
      redirect_to @topic
    else
      render 'edit'
    end
  end

  def destroy
  	@topic = Topic.find(params[:id])
  	@topic.destroy

  	render text: 'The topic has been destroyed. '
  end
end
