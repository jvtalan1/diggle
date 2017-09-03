class UsersController < ApplicationController
  before_action :find_user
  before_action :fetch_user_posts
  before_action :fetch_user_followers
  before_action :fetch_user_following
  before_action :fetch_user_stats

  def show
    render 'users/profile/show'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def fetch_user_posts
    @posts = Post.where(user_id: @user.id)
  end

  def fetch_user_followers
    @followers = @user.followers

    @current_user_following = []
    @followers.each do |user|
      if current_user.following?(user)
        @current_user_following << user
      end
    end
  end

  def fetch_user_following
    @following = @user.following
    @users_to_follow = []
    @following.each do |user|
      if !current_user.following?(user)
        @users_to_follow << user
      end
    end
  end

  def fetch_user_stats
    @followers_count = @followers.count
    @following_count = @following.count
    @posts_count = @posts.count
    @followers_following = @current_user_following.count
  end
end
