# Rails Video Chat App

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
* Password protect my room
* upload a brand "logo" to customize
* change page background color

___

# Models

* Room
  - belongs_to user
  - has_many messages
  - status: 0 (temporary), 1 (public), 2 (private)
  - status: `integer`
  - name: `string`
  - contains ICE creds
* Message
  - belongs_to room
  - belongs_to user
* User
  - has_many messages
  - has_one room
