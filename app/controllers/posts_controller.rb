class PostsController < ApplicationController

  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_post_type, :only => [:new, :create, :update]

  def index
    @posts = Post.recent
    
    respond_to do |format|
      format.html # render index.html.erb
      format.atom # render index.atom.builder
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = @post_type.capitalize.constantize.new
  end

  def create
    @post = @post_type.capitalize.constantize.new(params[@post_type.to_sym])
    
    if @post.save
      redirect_to(posts_path, :notice => "Success")
    else
      render :new, :alert => "Fail"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = @post_type.capitalize.constantize.find(params[:id])
    
    if @post.update_attributes(params[@post_type.to_sym])
      redirect_to(posts_path, :notice => "Success")
    else
      render :new, :alert => "Fail"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    
    @post.destroy
    redirect_to(posts_path, :notice => "Success")
  end

private

  def find_post_type
    @post_type = params[:post_type]
  end

end
