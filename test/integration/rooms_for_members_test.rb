require 'test_helper'

# :nodoc:
class RoomsForMembersTest < ActionDispatch::IntegrationTest
  def setup
    @kramers_room = rooms(:restricted_room)
    @jerrys_room  = rooms(:unrestricted_room)
    @kramer       = users(:kramer)
    @jerry        = users(:jerry)

    log_in_as(@jerry)
  end

  test 'cannot claim another user\'s room' do
    get claim_room_path(@kramers_room)
    refute_equal @kramers_room.user, @jerry
  end

  test 'cannot toggle room status of another user\'s room' do
    get toggle_status_room_path(@kramers_room, status: :unrestricted)
    assert_equal @kramers_room.status, 'restricted'
  end

  test 'cannot set a room to private using #toggle_status' do
    get toggle_status_room_path(@jerrys_room, status: :restricted)
    assert_equal @jerrys_room.status, 'unrestricted'
  end

  test 'can create a room' do
    get new_room_path
    assert_select 'input#room_name'

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'jerrys room' } }
    end
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
    password_hash = private_room.check_hashed_password(private_room.password)

    assert_equal password_hash, 'foobar'
    assert_equal private_room.status, 'restricted'
  end

  test 'can add a password to their room' do
    get new_room_path
    assert_select 'input#room_name'

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'jerrys room' } }
    end

    room = Room.find_by_slug('jerrys-room')
    patch room_path(room), params: { room: { password: 'foobar' } }

    room.reload
    password = room.password
    assert_equal room.check_hashed_password(password), 'foobar'
    assert_equal room.status, 'restricted'
  end

  test 'can make a private room public' do
    log_out
    log_in_as(@kramer)

    password = @kramers_room.password
    assert_equal @kramers_room.status, 'restricted'
    assert_equal @kramers_room.check_hashed_password(password), 'foobar'

    get toggle_status_room_path(@kramers_room, status: :unrestricted)

    @kramers_room.reload
    assert_equal @kramers_room.status, 'unrestricted'
    assert_nil @kramers_room.password
  end
end
