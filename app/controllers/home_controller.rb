class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_user_following
  before_action :fetch_user_stats, only: [:index]
  before_action :fetch_posts, only: [:index]
  before_action :fetch_unconnected_users, only: [:index]

  def index
    @post = Post.new
  end

  def refresh_users
    fetch_unconnected_users
    render partial: 'relationships/follow', locals: {users: @users}
  end
  
  private

  def fetch_user_following
    @following_ids = current_user.following.ids << current_user.id
  end

  def fetch_posts
    @posts = Post.where(user_id: @following_ids).order('created_at DESC').page(params[:page]).per(5)
  end

  def fetch_user_stats
    @following = current_user.following.count
    @followers = current_user.followers.count
    @posts_count = Post.where(user_id: current_user.id).count
  end

  def fetch_unconnected_users
    @users = User.where.not(id: @following_ids).shuffle[0..4]
  end
end
