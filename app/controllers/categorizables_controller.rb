class CategorizablesController < ApplicationController
  respond_to :html, :json

  def edit_topic_list
  	@categorizable = params[:categorizable_klass].constantize.find(params[:categorizable_id])
  	@name = params[:name]
  end

  def update_topic_list
  	@categorizable = params[:categorizable_klass].constantize.find(params[:categorizable_id])
  	@categorizable.__topics_string = params[:categorizable][:__topics_string]
  end
end