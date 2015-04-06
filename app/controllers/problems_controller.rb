class ProblemsController < ApplicationController
  respond_to :html, :json

  def show
  	@problem = Problem.find(params[:id])
  end

  def new
    @problem = Problem.new
  end

  def edit
  	@problem = Problem.find(params[:id])
  end

  def merge
    @problem = Problem.find(params[:problem_id])
    @original_problem = Problem.find(params[:problem_merge][:original_problem_id])

    @original_problem.topics << @problem.topics
    @original_problem.solutions << @problem.solutions

    @problem.sources.each do |s|
      p_ids_array = s.problem_ids.split(',').map(&:strip).reject(&:empty?).map(&:to_i)
      p_ids_array[ p_ids_array.index(@problem.id) ] = @original_problem.id
      s.problem_ids = p_ids_array.join(',')
      s.save
    end

    @problem.destroy
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
    @problem = Problem.find(params[:id])
    if @problem.update(problem_params)  
      respond_with(@problem)
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
