class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:edit, :show, :update, :delete]

  def index
    @posts = Post.where(id: current_user.following.ids)
    @users = User.where.not(id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post was successfully created."
      redirect_to post_path(@post)
    else
      flash[:alert] = "There was an error creating new post."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was successfully updated."
      redirect_to post_path(@post)
    else
      flash[:alert] = "There was an error updating the post."
      render :edit
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
