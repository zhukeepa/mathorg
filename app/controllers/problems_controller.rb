class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def show
  end

  def new
    @problem = Problem.new
  end

  def edit
  end

  def merge
    @problem = Problem.find(params[:problem_id])
    @original_problem = Problem.find(params[:problem_merge][:original_problem_id])
    
    @original_problem.merge_with_duplicate(@problem)

    redirect_to @original_problem
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
    if @problem.update(problem_params)  
      respond_with(@problem)
    else
      render 'edit'
    end
  end

  def destroy
    @problem.destroy

    render text: "The problem has been destroyed."
  end

private 
  def problem_params
    params[:problem].permit(:source, :author, :body, :description, :topics_string)
  end

  def set_problem 
    @problem = Problem.find(params[:id])
  end
end
