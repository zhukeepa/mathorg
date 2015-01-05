class TopicsController < ApplicationController
  autocomplete :topic, :name

  def show
    @topic = Topic.find(params[:id])

    # ::TODO:: once you finalize how you want to internally store Topics, either choose to replace
    # @topic_problems in the view with @topic.problems (resp solutions) or revert back
    # to commented versions. 
    descendant_topics = @topic.descendant_topics
    @topic_problems  = @topic.problems#descendant_topics.map(&:problems).reduce(:|)
    @topic_solutions = @topic.solutions#descendant_topics.map(&:solutions).reduce(:|)
  end

  def index
  	#@root_topics = Topic.all.keep_if { |t| t.parents.size == 0 }
    @topic = Topic.find_by_name("Math contests")
  end

  def new
    @topic = Topic.new
    #::TODO:: temporary, for topic list loading. remove later
    @topic.parents = Topic.find_all_by_id([params[:parent_id]])
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
