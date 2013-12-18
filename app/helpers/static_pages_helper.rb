module StaticPagesHelper

  def get_popular_tags
    tag_hash = Hash.new(Tag.all.size)
    Tag.all.each do |tag|
    tag_hash[tag.name] = tag.posts.size
    end
    tag_hash.sort_by {|_, x| x}.reverse[0, 10]
  end

end
