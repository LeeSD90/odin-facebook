class UsersController < ApplicationController
require 'will_paginate/array'
    before_action   :authenticate_user!

    def index
        @users = User.paginate(:page => params[:page])
    end

    def show
        @user = User.find(params[:id])
        @friends = @user.get_friends.paginate(:page => params[:page], :per_page => 10)
        if current_user == @user
            @requests = @user.get_friend_requests.paginate(:page => params[:page])
            @post = @user.posts.build
        end
    end

end
