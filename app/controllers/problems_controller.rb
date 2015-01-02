class ProblemsController < ApplicationController
  def show
  	@problem = Problem.find(params[:id])
  end

  def new
    @problem = Problem.new
  end

  def edit
  	@problem = Problem.find(params[:id])
  end

  def create
  	@problem = Problem.new(params[:problem].permit(:source, :author, :body, :description))
  	if @problem.save
      @topics = Topic.topics_string_to_topics_array(params[:problem][:topics])
      @problem.topics = @topics

    	redirect_to action: :show, id: @problem.id
    else
      render 'new'
    end
  end

  def update
    @problem = Problem.find(params[:id])
    if @problem.update(params[:problem].permit(:source, :author, :body, :description))
      @topics = Topic.topics_string_to_topics_array(params[:problem][:topics])
      @problem.topics = @topics
      
    	redirect_to @problem
    else
      render 'edit'
    end
  end

  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    render text: "The problem has been destroyed."
  end
end
