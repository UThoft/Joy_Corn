class PostController < ApplicationController
  def view
    @post = Post.find(params[:post_id])
    render partial: 'post/view'
  end
end
