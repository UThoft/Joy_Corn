class ApplicationController < ActionController::Base
  include TheComments::ViewToken

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  alias_method :devise_current_user, :current_user

  # if user is logged in, return current_user, else return guest_user
  def current_user
    if devise_current_user
      if cookies[:guest_user_id]
        logging_in
        guest_user.destroy
        cookies.delete :guest_user_id
      end
      devise_current_user
    else
      guest_user
    end
  end

  def user_signed_in?
    !!devise_current_user
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(cookies[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    cookies[:guest_user_id] = nil
    guest_user
  end

  private

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
    # comment.user_id = current_user.id
    # comment.save!
    # end

    guest_likes = guest_user.likes
    current_user_likes = devise_current_user.likes
    guest_likes.each do |like|
      if current_user_likes.find_by_post_id(like.post_id).blank?
        like.user_id = devise_current_user.id
        like.save!
      else
        like.destroy
      end
    end
  end

  def create_guest_user
    u = User.create(:email => "guest_#{Time.now.to_i}#{rand(99)}@example.com", :password => "guest_#{Time.now.to_i}#{rand(99)}")
    u.save!(:validate => false)
    cookies[:guest_user_id] = {:value => u.id, :expires => 365.days.from_now}
    u
  end

end
