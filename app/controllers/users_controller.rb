class UsersController < ApplicationController
require 'will_paginate/array'
    before_action   :authenticate_user!

    def index
        @users = User.paginate(:page => params[:page])
    end

    def show
        @user = User.find(params[:id])
        @users = @user.get_friends.paginate(:page => params[:page])
    end

end
