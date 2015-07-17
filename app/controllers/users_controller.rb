class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:delete_notification]

  def show 
    @user = User.find(params[:id])
  end

  def delete_notification
    u = current_user
    i = params[:index].to_i

    n = u.notifications.size
    if i == 0
      new_notifications = u.notifications[1...n]
    else
      new_notifications = u.notifications[0..(i-1)] + u.notifications[(i+1)...n]
    end

    u.update(notifications: new_notifications)
    render partial: 'users/notifications', locals: { user: u }
  end
end
