class StaticPagesController < ApplicationController
  helper_method :default_post_panel, :get_post_media

  def index
  end

  def help
  end

  def post panel
    @keyword = params[:keyword]
    @is_type = params[:is_type]
  end
  def default_post_panel
    @keyword = "default"
    return_post(12, 0)
  end

  def return_post(post_number, start_point)
    if @keyword == "default"
      Post.order(created_at: :desc).limit(post_number).offset(start_point)
    elsif @is_type == 1
      Post.where(media_type: @keyword).order(created_at: :desc).limit(post_number).offset(start_point)
    else
      search_initial
    end
  end

  def search_initial
  #  Handle the search keyword to generate proper results.
  end

  def get_post_media(media_type, post_id)
    case media_type
      when "text"
        Text.where(post_id: post_id)
      when "image"
        Image.where(post_id: post_id)
      when "audio"
        Audio.where(post_id: post_id)
      when "video"
        Video.where(post_id: post_id)
      else
    #    do nothing.
    end
  end


end
