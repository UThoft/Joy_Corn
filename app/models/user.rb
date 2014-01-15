class User < ActiveRecord::Base
  include TheComments::User


  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :likes
  has_many :unlikes

  def like_post?(post_id)
    !!self.likes.find_by_post_id(post_id)
  end

  # can be replaced to TheCommentsUser as default
  def admin?
    self == User.first
  end

  def comments_admin?
    admin?
  end

  def comments_moderator? comment
    id == comment.holder_id
  end

end
