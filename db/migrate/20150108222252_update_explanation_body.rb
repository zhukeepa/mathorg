class UpdateExplanationBody < ActiveRecord::Migration
  def change
  	remove_column :explanations, :body
  end
end
