class Public::PostsController < ApplicationController
  before_action :correct_customer, only: [:edit, :update]

  def new
    @post = Post.new
    @specs = Spec.all
  end

  def index
    if params[:latest]
      @posts = Post.latestt.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    elsif params[:rank]
      @posts = Post.rank.page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @customer = @post.customer
    @post_tags = @post.tags
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to public_post_path(@post), notice: "You have created post successfully."
    else
      @post = Post.new(post_params)
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
       redirect_to public_post_path(@post.id),notice:'投稿完了しました:)'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to public_posts_path
    else
       @post = Post.find(params[:id])
      render 'show'
    end
  end

  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  def rank
  end

  private

  def post_params
    params.require(:post).permit(:title, :mother_board, :cpu, :memory, :storage, :graphic_board, :case, :case_fan, :power, :compatibility, :description, :star)
  end

  def correct_customer
    @post = Post.find(params[:id])
    @customer = @post.customer
    redirect_to(public_posts_path) unless @customer == current_customer
  end
end
