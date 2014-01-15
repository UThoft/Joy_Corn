class PostsController < ApplicationController
  def view
    @post = Post.find(params[:post_id])
    @comments = @post.comments.with_state([:draft, :published])
    render partial: 'posts/view'
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.with_state([:draft, :published])
    render partial: 'posts/view'
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if params[:add_text]
      @post.texts.build
    elsif params[:add_image]
      @post.images.build
    elsif params[:add_audio]
      @post.audios.build
    elsif params[:add_video]
      @post.videos.build
    elsif params[:add_tag]
      @post.tags.build
    elsif params[:add_like]
      @post.likes.build
    elsif params[:remove_element]
    else
      # set the default parameters
      if @post.user_id == '' || @post.user_id.nil?
        @post.user_id = 1
      end

      if @post.title == '' || @post.title.nil?
        @post.title = 'A New Joy'
      end


      # save goes like usual
      if @post.save
        flash[:notice] = "Successfully created recipe."
        redirect_to new_post_path and return
      end
    end
    render 'new'
  end

  private

  def post_params



    params.require(:post).permit(:title, :user_id, :media_type,
                                 texts_attributes: [:id, :_destroy, :content],
                                 images_attributes: [:id, :_destroy, :link],
                                 audios_attributes: [:id, :_destroy, :link],
                                 videos_attributes: [:id, :_destroy, :link],
                                 tags_attributes:   [:id, :_destroy, :name],
                                 likes_attributes:  [:id, :_destroy, :user_id, :post_id]
    )


  end

end
