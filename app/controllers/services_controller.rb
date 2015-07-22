class ServicesController < ApplicationController
  def preview
    custom_replacements = params[:custom_replacements]
    if custom_replacements == 'true'
      render json: { preview_html: RichText.new(text: params[:text]).to_html_with_custom_replacements }
    else 
      render json: { preview_html: RichText.new(text: params[:text]).to_html }
    end
  end
end
