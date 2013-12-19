class Post < ActiveRecord::Base
  has_many :texts
  has_many :images
  has_many :audios
  has_many :videos
  has_and_belongs_to_many :tags
  belongs_to :user
  has_many :likes
end
