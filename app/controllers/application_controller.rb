# :nodoc:
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session,
                       only: proc { |c| c.request.format.json? }
  skip_before_action :verify_authenticity_token
  include DeviseWhitelist
end
