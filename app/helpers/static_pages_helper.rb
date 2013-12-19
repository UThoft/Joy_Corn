module StaticPagesHelper

  def get_popular_tags
    tag_hash = Hash.new(Tag.all.size)
    Tag.all.each do |tag|
    tag_hash[tag.name] = tag.posts.size
    end
    tag_hash.sort_by {|_, x| x}.reverse[0, 10]
  end

  def get_hottest(type, value)
  #  support load the famous posts or authors within a time
    if type == 'post'
      get_hottest_posts_by_time(value)
    elsif type == 'author'
      get_hottest_authors_by_time(value)
    else
    end
  
  end
  
  private

  def get_hottest_posts_by_time(value)
    Like.where("created_at > ?", value).select('post_id').order(post_id: :asc).group('post_id')
  end

  def get_hottest_authors_by_time(value)

  end

end
