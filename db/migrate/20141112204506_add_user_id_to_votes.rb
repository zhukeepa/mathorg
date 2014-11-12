class AddUserIdToVotes < ActiveRecord::Migration
  def change
  	add_reference :votes, :user
  end
end
