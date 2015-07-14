class ServicesController < ApplicationController
  def preview
    render json: { preview_html: RichText.new(text: params[:text]).to_html }
  end
end
