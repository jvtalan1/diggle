class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_user_stats, only: [:index]
  before_action :fetch_posts, only: [:index]
  before_action :fetch_unconnected_users, only: [:index]

  def index
    @post = Post.new
  end
  
  private

  def fetch_posts
    @ids = current_user.following.ids << current_user.id
    @posts = Post.where(id: @ids).order('created_at DESC')
  end

  def fetch_user_stats
    @following = current_user.following.count
    @followers = current_user.followers.count
    @posts_count = Post.where(user_id: current_user).count
  end

  def fetch_unconnected_users
    @users = User.where.not(id: @ids).shuffle[0..4]
  end
end
