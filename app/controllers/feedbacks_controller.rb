class FeedbacksController < ApplicationController
  def index
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.save

    redirect_to action: :index
    flash[:notice] = "Thanks for sharing your feedback!"
  end

private
  def feedback_params
    params.require(:feedback).permit(:name, :email, :content)
  end
end
