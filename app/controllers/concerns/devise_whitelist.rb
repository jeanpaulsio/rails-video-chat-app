# Whitelist parameters for Devise
module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password,
               :password_confirmation, :remember_me)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password,
               :password_confirmation,
               :current_password)
    end
  end
end
