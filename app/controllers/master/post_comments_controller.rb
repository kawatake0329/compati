class Master::PostCommentsController < ApplicationController

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to master_post_path(params[:post_id])
  end
end
