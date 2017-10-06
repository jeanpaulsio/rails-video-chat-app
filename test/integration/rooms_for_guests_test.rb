require 'test_helper'

# :nodoc:
class RoomsForGuestsTest < ActionDispatch::IntegrationTest
  def setup
    get root_url
    assert_select 'input#room_name'

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'my room' } }
    end

    follow_redirect!
    assert_template 'rooms/show'
    assert_select 'div.alert-success'
    assert_select 'h1', 'my room'
  end

  test 'cannot claim a room' do
    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-notice', 'You must register to claim this room!'
  end

  test 'cannot change the status of a room' do
    get toggle_status_room_path(status: :unrestricted)
    follow_redirect!
    assert_select 'div.alert-notice', 'You must own this room to do that!'

    get toggle_status_room_path(status: :restricted)
    follow_redirect!
    assert_select 'div.alert-notice', 'You must own this room to do that!'
  end

  test 'can claim a room by registering' do
    sign_up_as(email: 'jerry@rails.com')
    follow_redirect!
    assert_select 'h1', 'my room'

    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-success', 'Room claimed'
  end
end
