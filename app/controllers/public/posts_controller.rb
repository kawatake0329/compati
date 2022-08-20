class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to public_post_path(@post), notice: "You have created post successfully."
    else
      @posts = Post.all
      render 'index'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :grade_id, :mother_board, :cpu, :memory, :storage, :graphic_board, :case, :power, :compatibility, :description)
  end
end
