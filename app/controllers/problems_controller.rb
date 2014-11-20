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
  	@problem = Problem.new(params[:problem].permit(:source, :author, :body))
  	@problem.save

  	redirect_to action: :show, id: @problem.id
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.update(params[:problem].permit(:source, :author, :body))
  	redirect_to @problem
  end

  def destroy
  end
end
