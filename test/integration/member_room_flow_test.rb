require 'test_helper'

# :nodoc:
class MemberRoomFlowTest < ActionDispatch::IntegrationTest
  def setup
    room  = rooms(:restricted_room)
    jerry = users(:jerry)

    log_in_as(jerry)

    get room_path(room)
    assert_template 'rooms/show'
    assert_select 'h1', 'Restricted Room'
  end

  test 'cannot claim already claimed rooms' do
    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-notice', 'Room has been taken'
  end

  test 'cannot toggle status of someone else\'s room' do
    get toggle_status_room_path(status: :unrestricted)
    follow_redirect!
    assert_select 'div.alert-notice', 'You must own this room to do that!'
  end
end
