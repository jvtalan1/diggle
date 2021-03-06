class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :delete]

  def new
    @post = Post.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to authenticated_root_url }
        format.js { }
        format.json { render :index, status: :created, location: @post }

        @posts = Post.all
        ActionCable.server.broadcast 'posts', html: render_to_string('home/index', layout: false)
      else
        format.html { redirect_to authenticated_root_url }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Successfully deleted post."
      redirect_to authenticated_root_url
    else
      flash[:alert] = "There was an error deleting the post."
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:body, :picture)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
