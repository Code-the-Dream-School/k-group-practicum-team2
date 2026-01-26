class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :user_signed_in?, :current_user

  def current_user
    @current_user ||= warden.authenticate(scope: :user)
  end

  def user_signed_in?
    current_user.present?
  end
end
