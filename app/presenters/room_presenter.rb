class RoomPresenter
  include Rails.application.routes.url_helpers

  # model and view layer as args
  def initialize(room, template)
    @room     = room
    @template = template
  end

  def h
    @template
  end

  def register_link(current_user)
    return unless @room.user.nil? && (current_user.is_a? GuestUser)

    wrap_list h.link_to('Register to Claim',
                        new_user_registration_path(name: @room.name))
  end

  def claim_room_link(current_user)
    return unless @room.user.nil? && !(current_user.is_a? GuestUser)

    wrap_list h.link_to('Claim Room', claim_room_path(@room))
  end

  def toggle_status_link(current_user)
    return unless (@room.user == current_user) && (@room.restricted?)

    wrap_list h.link_to('Make Room Public',
                        toggle_status_room_path(@room, status: :unrestricted))
  end

  def room_settings_link(current_user)
    return unless @room.user == current_user

    wrap_list h.link_to('Room Settings', edit_room_path(@room))
  end

  private

  def wrap_list(link_to)
    '<li class="list-group-item">'.html_safe + link_to + '</li>'.html_safe
  end
end
