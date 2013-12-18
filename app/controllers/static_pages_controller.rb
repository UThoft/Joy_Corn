class StaticPagesController < ApplicationController
  helper_method :default_post_panel, :next_post_panel, :search_post_panel

  def index
    $current_index = 0
    $search_type = 'topic'
    $keyword = 'default'
  end

  def help
  end

  def next
  end

  def search
    $current_index = 0
    $search_type = params[:search_type]
    $keyword = params[:keyword]
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
  #  need to consider if there is search condition?
  end

  def return_post(post_number, start_point)
    if $keyword == "default"
      Post.order(created_at: :desc).limit(post_number).offset(start_point)
    elsif $is_type == 1
      Post.where(media_type: @keyword).order(created_at: :desc).limit(post_number).offset(start_point)
    else
      search_post_panel
    end
  end

  def search_post_panel

  end

  def search_post_panel_by(search_type, keyword)
  #  Handle the search keyword to generate proper results.


  end

  def return_post_search_by(search_type, keyword, post_number, start_point)

  end

  def home_button
    if request.original_url == root_path
      render root_path
    end
  end


end
