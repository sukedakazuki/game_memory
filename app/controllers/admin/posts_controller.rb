class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_post, only: [:show, :edit, :update]

  def index
    @posts = Post.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params) ? (redirect_to admin_post_path(@post)) : (render :edit)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :game_id, :rate, :comment)
  end

  def ensure_post
    @post = Post.find(params[:id])
  end
end
