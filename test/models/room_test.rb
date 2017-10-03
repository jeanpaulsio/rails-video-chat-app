require 'test_helper'

# :nodoc:
class RoomTest < ActiveSupport::TestCase
  def setup
    @temporary_room = rooms(:temporary_room)
  end

  test 'should not save a room without a name' do
    @temporary_room.name = ''
    assert_not @temporary_room.valid?
  end

  test 'should not save room name longer than 15 characters' do
    @temporary_room.name = 'a' * 16
    assert_not @temporary_room.valid?
  end

  test 'should not save a status higher than 2' do
    assert_raises(ArgumentError) do
      @temporary_room.status = 3
    end
  end

  test 'should not save a status unless valid' do
    assert_raises(ArgumentError) do
      @temporary_room.status = 'Invalid Status'
    end
  end

  test 'should create a room with a default status of 0' do
    room = Room.create!(name: 'Room')
    assert_equal room.status, 'temporary'
  end
end
