class CategorizablesController < ApplicationController
  def edit_topic_list
  	@categorizable = params[:categorizable_klass].constantize.find(params[:categorizable_id])
  	@name = params[:name]
  end

  def update_topic_list
  	@categorizable = params[:categorizable_klass].constantize.find(params[:categorizable_id])
  	@categorizable.topics = Topic.topics_string_to_topics_array(params[:categorizable][:topics])
  end
end