require 'application_system_test_case'

# :nodoc:
class RoomsTest < ApplicationSystemTestCase
  test 'creating a room' do
    visit root_url

    fill_in 'Name', with: 'Room 1'
    click_on 'Create Room'
    assert_text 'You created the room'
  end

  test 'claiming a room by registering' do
    visit root_url

    fill_in 'Name', with: 'Room 2'
    click_on 'Create Room'
    assert_text 'You created the room'

    click_on 'Register'
    fill_in 'Room name', with: 'Room 2'
    fill_in 'Email', with: 'jerry@rails.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_on 'Sign up'
    assert_text 'Welcome! You have signed up successfully.'

    # Type room name
    # Register
    # Redirect to /rooms/index.html.erb
    # Test to see that 'Room 2' is the only item in the list
  end
end
