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



  def get_like_number_by_post(post_id)
    Post.find(post_id).likes.size
  end

  def get_unlike_number_by_post(post_id)
    Post.find(post_id).unlikes.size
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

  module IpHelper

    def ip_to_int(ip_str)
      sub_ips = ip_str.to_s.split('.')
      ip_int = 0
      sub_ips.each do |sub_ip|
        ip_int = ip_int * 256 + sub_ip.to_s.to_i(10)
      end
      ip_int
    end

    def ip_masker(ip_str)
      sub_ips = ip_str.to_s.split('.')
      '[' + sub_ips[0] + '.' + sub_ips[1] + '.*' + ']'
    end

  end

end
