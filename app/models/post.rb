class Post < ActiveRecord::Base
  include TheComments::Commentable


  has_many :texts
  has_many :images
  has_many :audios
  has_many :videos
  has_and_belongs_to_many :tags
  belongs_to :user
  has_many :likes
  has_many :unlikes

  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :likes
  accepts_nested_attributes_for :texts
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :audios
  accepts_nested_attributes_for :videos

  def commentable_title
    title
  end

  def commentable_url
    ['', self.class.to_s.tableize, id].join('/')
  end

  def commentable_state
    :published.to_s
  end

end
