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

  test 'cannot set a room to private using #toggle_status' do
    get room_path(@jerrys_room)
    assert_template 'rooms/show'

    get toggle_status_room_path(status: :restricted)
    follow_redirect!
    assert_equal @jerrys_room.status, 'unrestricted'
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

  test 'can create a room with a password' do
    get new_room_path
    assert_select 'input#room_name'
    assert_select 'input#room_password'

    assert_difference 'Room.count', 1 do
      post rooms_path, params: {
        room: {
          name: 'private room',
          password: 'foobar'
        }
      }
    end

    private_room  = Room.find_by_slug('private-room')
    password_hash = BCrypt::Password.new(private_room.password)

    assert_equal password_hash, 'foobar'
    assert_equal private_room.status, 'restricted'
  end

  test 'can add a password to their room' do
    skip 'not yet implemented'
  end

  test 'can make a private room public' do
    skip 'not yet implemented'
  end
end
