module ApplicationHelper
  def login_helper(style = '')
    if user_signed_in?
      (link_to 'My Rooms', rooms_path, class: style) + "\n" +
      (link_to 'My Account', edit_user_registration_path, class: style) + "\n" +
      (link_to 'Logout', destroy_user_session_path, method: :delete, class: style)
    else
      (link_to 'Register', new_user_registration_path, class: style) + "\n" +
      (link_to 'Login', new_user_session_path, class: style)
    end
  end
end
