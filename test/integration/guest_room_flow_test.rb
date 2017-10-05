require 'test_helper'

# :nodoc:
class GuestRoomFlowTest < ActionDispatch::IntegrationTest
  test 'can see the form to create a room' do
    get root_url
    assert_select 'input#room_name'
  end

  test 'can create a room as a guest' do
    get root_url

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'room' } }
    end

    follow_redirect!
    assert_template 'rooms/show'
  end

  test 'can claim a room by registering' do
    get root_url

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'my room' } }
    end

    follow_redirect!
    assert_template 'rooms/show'
    assert_select 'h1', 'my room'

    sign_up_as(email: 'jerry@rails.com')
    follow_redirect!
    assert_select 'h1', 'my room'

    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-success', 'Room claimed'
  end

  test 'cannot claim a room without registering' do
    get root_url

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'my room' } }
    end

    follow_redirect!
    assert_template 'rooms/show'
    assert_select 'h1', 'my room'

    get claim_room_path
    follow_redirect!
    assert_select 'div.alert-notice', 'You must register to claim this room!'
  end

  test 'cannot change the status of a room without registering' do
    get root_url

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'my room' } }
    end

    follow_redirect!
    assert_template 'rooms/show'
    assert_select 'h1', 'my room'

    get toggle_status_room_path(status: :unrestricted)
    follow_redirect!
    assert_select 'div.alert-notice', 'You must own this room to do that!'
  end
end
