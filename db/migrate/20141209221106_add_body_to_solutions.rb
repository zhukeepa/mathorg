class AddBodyToSolutions < ActiveRecord::Migration
  def change
  	add_column :solutions, :body, :text
  end
end
