class AddOriginalToProblem < ActiveRecord::Migration
  def change
    add_reference :problems, :original, index: true
  end
end
