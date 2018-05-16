class FriendshipsController < ApplicationController

  def create
    user = User.find(params[:user])
    unless user.pending_request(current_user)
      current_user.send_request(user)
      flash[:notice] = "Friend request sent!"
    else
      flash[:notice] = "That user already has a pending friend request from you."
    end
    redirect_to user
  end

  def update
    user = User.find(params[:user])
    current_user.accept_request(user)
    flash[:success] = "You are now friends with #{user.name}!"
    redirect_to user
  end

  def destroy
  end

end
