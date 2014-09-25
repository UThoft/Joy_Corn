class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # def new
  #   @like = Like.new
  # end

  def create
    @like = Like.new(like_params)
    @post = Post.find(params[:post_id])
    if @like.save
      render 'shared/create_like'
    end

  end

  def destroy
    like = Like.find(params[:id])
    @post = like.post
    like.destroy unless like.blank?

    render 'shared/create_like'
  end
  
  private

  def like_params
    params.permit(:user_id, :post_id)
  end

end