class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy, :merge]
  before_action :authenticate_user!, except: [:show]
  respond_to :html, :json

  def show
  end

  def new
    @problem = Problem.new
  end

  def edit
  end

  def merge
    @original_problem = Problem.find(params[:problem_merge][:original_problem_id])
    @original_problem.merge_with_duplicate(@problem, params[:problem_merge][:should_merge_solutions])

    redirect_to @original_problem
  end

  def mark 
    # ::TODO:: xcxc ugly param pass
    @problem = Problem.find(params[:problem_id])
    markable = params[:markable].to_sym

    if !current_user.problems_marked_as(markable).include?(@problem)
      current_user.problems_marked_as(markable) << @problem 
    else 
      @problem.unmark(markable)
    end

    # ::TODO:: xcxc what to render for nothing's? 
    render text: "cool"
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
    params[:problem].permit(:source, :author, :body, :description, :topics_string, :markable)
  end

  def set_problem 
    @problem = Problem.find(params[:id])
  end
end
