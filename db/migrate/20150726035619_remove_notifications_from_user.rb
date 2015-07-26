class RemoveNotificationsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :notifications
  end
end
