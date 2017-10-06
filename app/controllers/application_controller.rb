# :nodoc:
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session,
                       only: proc { |c| c.request.format.json? }
  skip_before_action :verify_authenticity_token

  before_action :store_user_location!, if: :storable_location?
  include CurrentUserConcern

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
