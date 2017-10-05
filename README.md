# Rails Video Chat App

## TODO

* Create system tests

## As a user, I can...

* create a room on the fly
* Send links to a room
* Enter into an existing room
* Mute my microphone
* Turn my video off
* send chat messages to the room

## As a guest, I can...

* Create temporary rooms that expire in 24 hours
* "register now to claim this room"

## As a member, I can...

* Claim a room name
* Password protect my room - some kind of authorization
* upload a brand "logo" to customize
* change page background color

___

# Models

* Room
  - belongs_to user
  - has_many messages
  - id: `integer`
  - status: `integer`
  - name: `string`
  - user_id: `reference`
* User
  - has_many messages
  - has_many rooms
  - id: `integer`
  - email: `string`
* Message
  - belongs_to room
  - belongs_to user
  - id: `integer`
  - content: `text`
  - user_id: `reference`
  - room_id: `reference`
