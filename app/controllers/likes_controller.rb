class LikesController < ApplicationController
  before_action   :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @like = post.likes.build(:user_id => current_user.id)
    if @like.save
      flash[:success] = "Post liked!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Couldn't like that post for some reason..."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

end
