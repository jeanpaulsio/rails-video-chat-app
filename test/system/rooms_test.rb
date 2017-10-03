require 'application_system_test_case'

class RoomsTest < ApplicationSystemTestCase
  test 'creating a room' do
    visit root_url

    fill_in 'Name', with: 'Room Name'
    click_on 'Create Room'
    assert_text "Room#show"
  end
end
