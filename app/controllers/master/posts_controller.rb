class Master::PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page])
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_tags = @post.tags

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
      redirect_to master_post_path, notice: "編集完了しました"
    else
      @post = Post.find(params[:id])
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to master_posts_path
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

  private

  def post_params
    params.require(:post).permit(:title, :mother_board, :cpu, :memory, :storage, :graphic_board, :case, :case_fan, :power, :compatibility, :description, :star)
  end
end
