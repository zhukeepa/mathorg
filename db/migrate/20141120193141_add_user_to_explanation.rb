class AddUserToExplanation < ActiveRecord::Migration
  def change
    add_reference :explanations, :user, index: true
  end
end
