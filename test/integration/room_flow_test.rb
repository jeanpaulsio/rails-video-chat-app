require 'test_helper'

# :nodoc:
class RoomFlowTest < ActionDispatch::IntegrationTest
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

  test 'can create a room as a member' do
    skip 'not yet implemented'
  end
end
