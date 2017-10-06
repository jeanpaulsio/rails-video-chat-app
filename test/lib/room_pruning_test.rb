require 'test_helper'

# :nodoc:
class RoomPruningTest < ActiveSupport::TestCase
  test 'tests rake task' do
    VideoChatApp::Application.load_tasks
    Rake::Task['rooms:destroy_temporary_all'].invoke
    assert_equal Room.temporary.count, 0

    Rake::Task['rooms:create_temporary_old'].invoke
    assert_equal Room.temporary.count, 10

    Rake::Task['rooms:create_temporary_new'].invoke
    assert_equal Room.temporary.count, 15

    Rake::Task['rooms:destroy_temporary_old'].invoke
    assert_equal Room.temporary.count, 5

    Rake::Task.clear
  end
end
