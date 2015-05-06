class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update,:destroy]
  before_action :authenticate_user!, except: [:show, :index]
  autocomplete :topic, :name

  def show
  end

  def index
  	#@root_topics = Topic.all.keep_if { |t| t.parents.size == 0 }
    @topics = Topic.all # find_by_name("Math contests")
  end

  def new
    @topic = Topic.new
    @topic.parents = Topic.find_all_by_id([params[:parent_id]])
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)
    
    if @topic.save
      redirect_to action: :show, id: @topic.id
    else
      render 'new'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic
    else
      render 'edit'
    end
  end

  def destroy
  	@topic.destroy

  	render text: 'The topic has been destroyed. '
  end

private 
  def topic_params
    params[:topic].permit(:name, :parents_string)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
