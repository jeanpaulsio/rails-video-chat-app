require 'test_helper'

# :nodoc:
class RoomsForMembersTest < ActionDispatch::IntegrationTest
  def setup
    @kramers_room = rooms(:restricted_room)
    @jerry        = users(:jerry)

    log_in_as(@jerry)
  end

  test 'cannot claim another user\'s room' do
    get room_path(@kramers_room)

    assert_template 'rooms/show'
    assert_select 'h1', 'Restricted Room'

    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-notice', 'Room has been taken'
  end

  test 'cannot toggle room status of another user\'s room' do
    get room_path(@kramers_room)

    assert_template 'rooms/show'
    assert_select 'h1', 'Restricted Room'

    get toggle_status_room_path(status: :unrestricted)
    follow_redirect!
    assert_select 'div.alert-notice', 'You must own this room to do that!'
  end

  test 'can create a room' do
    get new_room_path
    assert_select 'input#room_name'

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: "jerry's room" } }
    end

    follow_redirect!
    assert_template 'rooms/show'
    assert_select 'div.alert-success'
    assert_select 'h1', "jerry's room"
  end
end
