class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @Post.tag
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    #tag_list = params[:post][:name].split(',')
    if @post.save
      #@post.save_tag(tag_list)
      redirect_to public_posts_path, notice: "You have created post successfully."
    else
      @posts = Post.all
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])

     @tag_list=@post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
       @post.save_tag(tag_list)
       redirect_to post_path(@post.id),notice:'投稿完了しました:)'
    else
      render:edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :mother_board, :cpu, :memory, :storage, :graphic_board, :case, :power, :compatibility, :description)
  end
end
