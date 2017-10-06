module CurrentUserConcern
  extend ActiveSupport::Concern

  def current_user
    super || guest_user
  end

  def guest_user
    guest       = GuestUser.new
    salt        = BCrypt::Engine.generate_salt
    guest.email = "guest+#{salt}@example.com"
    guest
  end
end
