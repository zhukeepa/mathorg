class ProblemResourcesController < ApplicationController
  def new
  	@problem_resource = ProblemResource.new 
  end

  def create
    @pr = ProblemResource.new(params[:problem_resource].permit(:title, :name))
    @pr.problem_ids = params[:problem_resource][:problem_ids].split(",").map(&:strip).uniq.reject(&:empty?)

    @pr.save
    redirect_to action: :show, id: @pr.title
  end

  def show
    @pr = ProblemResource.find_by(title: params[:id])
    @problems = @pr.problem_ids.map { |id| Problem.find(id) }
  end
end
