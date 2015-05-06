class AddAuthorsToExplanation < ActiveRecord::Migration
  def change
    add_column :explanations, :authors, :text
  end
end
