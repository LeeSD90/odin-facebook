class FriendshipsController < ApplicationController

  def create
    user = User.find(params[:user])
    current_user.send_request(user)
    flash[:notice] = "Friend request sent!"
    redirect_to user
  end

  def update
    user = User.find(params[:user])
    current_user.accept_request(user)
    flash[:success] = "You are now friends with #{user.email}!"
    redirect_to user
  end

  def destroy
  end

end
