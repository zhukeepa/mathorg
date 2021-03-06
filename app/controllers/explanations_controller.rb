class ExplanationsController < ApplicationController
  before_action :set_explanation, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  
  def new 
    @explanation = Explanation.new(body: RichText.new, authors_string: current_user.username)
  end

  def edit
  end

  def create
    @explanation = Explanation.new(explanation_params)
    if @explanation.save
      redirect_to action: :show, id: @explanation.id
    else
      render 'new'
    end
  end

  def index 
    @explanations = Explanation.all#where(title: ["Symmedians", 
                                   #           "Weights & Coloring", 
                                   #           "Integer Polynomials", 
                                   #           "Inversion"])
  end

  def update
    @explanation.update(explanation_params)

    redirect_to @explanation
  end

  def show
  end

  def destroy
    @explanation.destroy

    render text: "Your explanation has been destroyed." 
  end

private
  def explanation_params
    params.require(:explanation)
      .permit(:authors_string, :title, :description, :topics_string, body_attributes: [:text])
  end

  def set_explanation
    @explanation = Explanation.find(params[:id])
  end
end