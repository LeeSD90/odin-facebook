class PostsController < ApplicationController
  before_action   :authenticate_user!
  
  def index
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to current_user
    else
      flash[:error] = "Error creating post..."
      redirect_to current_user
    end
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
    
end
