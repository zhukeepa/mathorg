class AddUserIdToSolution < ActiveRecord::Migration
  def change
  	add_reference :solutions, :author, index: true
  end
end
