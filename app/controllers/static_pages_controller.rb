class StaticPagesController < ApplicationController
  helper_method :default_post_panel, :next_post_panel

  def index
  end

  def help
  end

  def next
  end

  def post panel
    $keyword = params[:keyword]
    $is_type = params[:is_type]
  end

  def default_post_panel
    $keyword = "default"
    $current_index = 12
    return_post(12, 0)
  end

  # return the next post page to enable infinite scroll.
  def next_post_panel
    temp = return_post(3, $current_index)
    $current_index = $current_index + 3
    temp
  end

  def return_post(post_number, start_point)
    if $keyword == "default"
      Post.order(created_at: :desc).limit(post_number).offset(start_point)
    elsif $is_type == 1
      Post.where(media_type: @keyword).order(created_at: :desc).limit(post_number).offset(start_point)
    else
      search_initial
    end
  end

  def search_initial
  #  Handle the search keyword to generate proper results.
  end

  def home_button
    if request.original_url == root_path
      render root_path
    end
  end


end
