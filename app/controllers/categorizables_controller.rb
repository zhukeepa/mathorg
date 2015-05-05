class CategorizablesController < ApplicationController
  respond_to :html, :json

  def update_topic_list
  	@categorizable = params[:klass].constantize.find(params[:id])
  	@categorizable.__topics_string = params[:topics_string]
    render partial: 'categorizables/topic_list', locals: { categorizable: @categorizable, name: params[:name] }
  end
end