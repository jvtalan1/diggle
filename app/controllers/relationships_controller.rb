class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    fetch_next_user

    respond_to do |format|
      format.html { redirect_to authenticated_root_url }
      format.js { }
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to authenticated_root_url
  end

  private

  def fetch_next_user
    ids = current_user.following.ids << current_user.id
    @next_user = []
    @next_user[0] = User.where.not(id: ids).shuffle[0]
  end
end
