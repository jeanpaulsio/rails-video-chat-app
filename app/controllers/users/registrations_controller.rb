# :nodoc:
class Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def sign_up_params
    params.require(:registration).permit(:email,
                                         :password,
                                         :password_confirmation)
  end
end
