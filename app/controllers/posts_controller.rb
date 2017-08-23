class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :delete]

  def index
    @post = Post.new
    @posts = Post.where("user_id IN (?) OR user_id IN (?)", current_user.following.ids, current_user.id).order('created_at DESC')
    ids = User.where.not("id IN (?) OR id IN (?)", current_user.following.ids, current_user.id).pluck(:id).shuffle[0..5]
    @users = User.where(id: ids)
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post was successfully created."
      redirect_to posts_path
    else
      flash[:alert] = "There was an error creating new post."
      redirect_to posts_path
    end
  end

  def show
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Successfully deleted post."
      redirect_to posts_path
    else
      flash[:alert] = "There was an error deleting the post."
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
