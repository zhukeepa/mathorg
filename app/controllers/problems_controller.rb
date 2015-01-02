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
  	@problem = Problem.new(problem_params)
  	if @problem.save
    	redirect_to action: :show, id: @problem.id
    else
      render 'new'
    end
  end

  def update
    @problem = Problem.find(params[:id])
    if @problem.update(problem_params)  
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

private 
  def problem_params
    params[:problem].permit(:source, :author, :body, :description, :topics_string)
  end
end
