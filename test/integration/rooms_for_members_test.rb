require 'test_helper'

# :nodoc:
class RoomsForMembersTest < ActionDispatch::IntegrationTest
  def setup
    @kramers_room = rooms(:restricted_room)
    @jerrys_room  = rooms(:unrestricted_room)
    @jerry        = users(:jerry)

    log_in_as(@jerry)
  end

  test 'cannot claim another user\'s room' do
    get room_path(@kramers_room)
    assert_template 'rooms/show'

    get claim_room_path
    follow_redirect!
    assert_select 'div#flash-message', 'You are not allowed to do that!'
  end

  test 'cannot toggle room status of another user\'s room' do
    get room_path(@kramers_room)
    assert_template 'rooms/show'

    get toggle_status_room_path(status: :unrestricted)
    follow_redirect!
    assert_select 'div#flash-message', 'You are not allowed to do that!'
  end

  test 'can create a room' do
    get new_room_path
    assert_select 'input#room_name'

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: "jerry's room" } }
    end

    follow_redirect!
    assert_template 'rooms/show'
  end
end
