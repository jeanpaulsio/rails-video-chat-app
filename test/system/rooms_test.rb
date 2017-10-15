require 'application_system_test_case'

# :nodoc:
class RoomsTest < ApplicationSystemTestCase
  def setup
    @jerrys_room = rooms(:unrestricted_room)
  end

  test 'creating a room' do
    skip 'UI not completed'
    visit root_url

    fill_in 'Room Name', with: 'Room 1'
    click_on 'Create New Room'
    assert_text 'Join Room'
  end

  test 'claiming a room by registering' do
    skip 'UI not completed'

    visit root_url

    fill_in 'Name', with: 'Room 2'
    click_on 'Create New Room'
    assert_text 'Invite by sharing this link:'

    click_on 'Register'
    fill_in 'Email', with: 'jerry@rails.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_on 'Sign up'
    assert_text 'Welcome! You have signed up successfully.'
    assert_text 'Room 2'

    click_on 'claim room'
    assert_text 'Room claimed'
  end

  test 'can enter an existing room from anywhere' do
    skip 'UI not completed'

    visit room_path(@jerrys_room)
    assert_text 'Join Room'
  end

  test 'friendly message when entering a non existent room' do
    skip 'not yet implemented'
  end

  test 'can create a room with a password' do
    skip 'not yet implemented'
  end

  test 'gracefully handles failed ICE requests' do
    skip 'not yet implemented'
  end
end
