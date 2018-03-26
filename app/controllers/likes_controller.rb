class LikesController < ApplicationController
  before_action :find_post, only: [:create, :destroy]

  def create
    current_user.likes.create(post_id: @post.id)
    redirect_to posts_path
  end

  def destroy
    @like = @post.likes.find_by(params[:user_id])
    if current_user == @like.user
      @like.destroy!
    else
      flash[:alert] = "That is not your like to delete!"
    end
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
