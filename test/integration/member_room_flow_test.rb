require 'test_helper'

# :nodoc:
class MemberRoomFlowTest < ActionDispatch::IntegrationTest
  test 'cannot claim an owned rooms' do
    room  = rooms(:restricted_room)
    jerry = users(:jerry)

    log_in_as(jerry)

    get room_path(room)
    assert_template 'rooms/show'
    assert_select 'h1', 'Restricted Room'

    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-notice', 'Room has been taken'
  end

  test 'can only toggle status of owned room' do
    room  = rooms(:restricted_room)
    jerry = users(:jerry)

    log_in_as(jerry)

    get room_path(room)
    assert_template 'rooms/show'
    assert_select 'h1', 'Restricted Room'

    get toggle_status_room_path(status: :unrestricted)
    follow_redirect!
    assert_select 'div.alert-notice', 'You must own this room to do that!'
  end
end
