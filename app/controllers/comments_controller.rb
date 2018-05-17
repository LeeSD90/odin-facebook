class CommentsController < ApplicationController
  before_action   :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Error adding comment..."
      redirect_to current_user
    end
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :content)
    end
end
