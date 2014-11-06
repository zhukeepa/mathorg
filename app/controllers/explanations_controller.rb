class ExplanationsController < ApplicationController
	def new 
	end

	def edit
		@explanation = Explanation.find(params[:id])
	end

	def create
		@explanation = Explanation.new(params[:explanation].permit(:title, :description, :body))
    	@explanation.save
    	redirect_to action: :show, id: @explanation.id
	end

	def show
		@explanation = Explanation.find(params[:id])
	end
end
