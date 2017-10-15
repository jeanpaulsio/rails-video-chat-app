require 'test_helper'

# :nodoc:
class RoomsForGuestsTest < ActionDispatch::IntegrationTest
  def setup
    get root_url

    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { name: 'my room' } }
    end

    @room = Room.find_by_slug('my-room')
  end

  test 'cannot claim a room' do
    get claim_room_path(@room)
    @room.reload

    assert_nil @room.user
  end

  test 'cannot change the status of a room' do
    get toggle_status_room_path(@room, status: :unrestricted)
    assert_equal @room.status, 'temporary'

    get toggle_status_room_path(@room, status: :restricted)
    assert_equal @room.status, 'temporary'
  end

  test 'can claim a room by registering' do
    sign_up_as(email: 'jerry@rails.com')

    get claim_room_path(@room)
    @room.reload
    assert_equal @room.user.email, 'jerry@rails.com'
  end

  test 'cannot password protect a room' do
    patch room_path(@room), params: { room: { password: 'foobar' } }
    @room.reload

    assert_nil @room.password
  end
end
