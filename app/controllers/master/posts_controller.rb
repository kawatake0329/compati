class Master::PostsController < ApplicationController

  def index
    @posts = Post.all
    @tag_list=Tag.all
  end

  def show
    @psot = Post.find(params[:id])
    @customer = @post.customer
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    
  end

  def update
    @post = Post.find(params[:id])
    if @post.update
      redirect_to master_post_path, notice: "編集完了しました"
    else
      @post = Post.find(params[:id])
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to master_posts_path
    else
      @post = Post.find(params[:id])
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :mother_board, :cpu, :memory, :storage, :graphic_board, :case, :power, :compatibility, :description)
  end
end
