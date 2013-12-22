class StaticPagesController < ApplicationController
  helper_method :default_post_panel, :next_post_panel

  def index
    $current_index = 0
    $search_type = 'topic'
    $keyword = 'default'
    gon.global.current_menu = "#topics"
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
    temp = return_post_search_by($search_type, $keyword, 12, $current_index)
    $current_index = $current_index + 12
    temp
  end

  # return the next posts page to enable infinite scroll.
  def next_post_panel
    temp = return_post_search_by($search_type, $keyword, 3, $current_index)
    $current_index = $current_index + 3
    temp
  #  need to consider if there is search condition?
  end

  def return_post_default(post_number, start_point)
    Post.order(created_at: :desc).limit(post_number).offset(start_point)
  end

  def return_post_search_by(search_type, keyword, post_number, start_point)
    if search_type == 'topic'
      if keyword == 'default'
        return_post_default(post_number, start_point)
      end
    elsif search_type == 'type'
      Post.where(media_type: keyword).limit(post_number).offset(start_point).order(created_at: :desc)
    elsif search_type == 'tag'
      Tag.find_by_name(keyword).posts.limit(post_number).offset(start_point).order(created_at: :desc)
    elsif search_type == 'time'
      Post.where("created_at >= ?", keyword).limit(post_number).offset(start_point).order(created_at: :desc)
    elsif search_type == 'author'
      User.find_by_name(keyword).posts.limit(post_number).offset(start_point).order(created_at: :desc)
    else
    end
  end

  def post_filter(filter_type, keyword)
  #  filter the posts by keyword
  end


end
