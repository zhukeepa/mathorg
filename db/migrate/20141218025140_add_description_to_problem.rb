class AddDescriptionToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :description, :string
  end
end
