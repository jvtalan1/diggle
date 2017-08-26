class UsersController < ApplicationController
  before_action :find_user
  before_action :fetch_user_posts
  before_action :fetch_user_followers
  before_action :fetch_user_following

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
    @followers = @user.followers.count
    @following = @user.following.count
    @posts_count = @posts.count

    @users_followed = []
    @user.followers.each do |user|
      if current_user.following?(user)
        @users_followed << user
      end
    end
    @users_followed_count = @users_followed.count
  end

  def fetch_user_following
    @users = @user.following
    @users_to_follow = []
    @users.each do |user|
      if !current_user.following?(user)
        @users_to_follow << user
      end
    end
  end
end
