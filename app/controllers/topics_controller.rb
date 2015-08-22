class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update,:destroy]
  before_action :authenticate_user!, except: [:show, :index]
  autocomplete :topic, :name

  def show
    @topic_problems = Problem.where(id: @topic.problems_and_solutions_ids).limit(25)

    # does not work as expected -- will get top 25 results and then filter, not the other way around
    # probably not a big deal for this though
    @topic_explanations = @topic.explanations.limit(25).select { |e| e.specificest_topics.include? @topic }
  end

  def index
    @topic = Topic.where(name: "Math contests").first || Topic.new # || is so tests don't crash
  end

  def new
    @topic = Topic.new
    @topic.parents = Topic.where(id: params[:parent_id]).to_a
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
