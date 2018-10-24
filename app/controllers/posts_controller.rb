class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if params[:location].blank?
      @posts = Post.all.order("created_at DESC")
    else
      @location_id = Location.find_by(name: params[:location]).id
      @posts = Post.where(:location_id => @location_id).order("created_at DESC")
    end
  end

  def new
    @post = current_user.posts.build
    @locations = Location.all.map{ |l| [l.name, l.id] }
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.location_id = params[:location_id]
    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @locations = Location.all.map{ |l| [l.name, l.id] }
  end

  def update
    @post.location_id = params[:location_id]
    if @post.update(post_params)
      flash[:notice] = "Post successfully edited"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def upvote
    @post.upvote_by current_user
    flash[:notice] = "Post upvoted!"
    redirect_to posts_path
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post successfully deleted"
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :image, :location_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
