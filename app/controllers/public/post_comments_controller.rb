class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if@post_comment.save
      render :create
    else
      @post = Post.find(params[:post_id])
      redirect_to public_post_path(@post)
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    render :destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :rate)
  end
end
