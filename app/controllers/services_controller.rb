class ServicesController < ApplicationController
  def preview
    render json: { preview_html: params[:text].bbcode_to_html.gsub("\n", "<br/>") }
  end
end
