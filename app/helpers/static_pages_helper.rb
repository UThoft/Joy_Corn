module StaticPagesHelper

  def get_popular_tags
    tag_hash = Hash.new(Tag.all.size)
    Tag.all.each do |tag|
    tag_hash[tag.name] = tag.posts.size
    end
    tag_hash.sort_by {|_, x| x}.reverse[0, 10]
  end

  def get_hottest(type, value, number)
  #  support load the famous posts or authors within a time
    if type == 'post'
      get_hottest_posts_by_time(value, number)
    elsif type == 'author'
      get_hottest_authors_by_time(value, number)
    else
    end
  
  end
  
  private

  def get_hottest_posts_by_time(value, number)
    Like.where("created_at > ?", value).select('post_id').order(post_id: :asc).group('post_id').limit(number)
  end

  def get_hottest_authors_by_time(value, number)

  end


  def get_proper_media_by_size(post, height, width)
    if post.instance_of?(Post)

    else
    end
  end

end
