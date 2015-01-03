class CategorizablesController < ApplicationController
  respond_to :html, :json

  def edit_topic_list
  	@categorizable = params[:categorizable_klass].constantize.find(params[:categorizable_id])
  	@name = params[:name]
  end

  def update_topic_list
  	@categorizable = params[:categorizable_klass].constantize.find(params[:categorizable_id])
  	@categorizable.topics_string = params[:categorizable][:topics_string]
  end
end