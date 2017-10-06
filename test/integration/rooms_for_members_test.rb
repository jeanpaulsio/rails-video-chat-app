require 'test_helper'

# :nodoc:
class RoomsForMembersTest < ActionDispatch::IntegrationTest
  def setup
    kramers_room = rooms(:restricted_room)
    jerry        = users(:jerry)

    log_in_as(jerry)
    get room_path(kramers_room)

    assert_template 'rooms/show'
    assert_select 'h1', 'Restricted Room'
  end

  test 'cannot claim someone else\'s room' do
    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-notice', 'Room has been taken'
  end

  test 'can only toggle status of owned room' do
    get toggle_status_room_path(status: :unrestricted)
    follow_redirect!
    assert_select 'div.alert-notice', 'You must own this room to do that!'
  end
end
