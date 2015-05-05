class TopicablesController < ApplicationController
  respond_to :html, :json

  def update_topic_list
  	@topicable = params[:klass].constantize.find(params[:id])
  	@topicable.__topics_string = params[:topics_string]
    render partial: 'topicables/topic_list', locals: { topicable: @topicable, name: params[:name] }
  end
end