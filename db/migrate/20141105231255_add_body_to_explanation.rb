class AddBodyToExplanation < ActiveRecord::Migration
  def change
    add_column :explanations, :body, :text
  end
end
