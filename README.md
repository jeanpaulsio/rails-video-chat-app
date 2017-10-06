# Rails Video Chat App

## TODO

* Create system tests
* Test coverage for WebRTC JS stuff

___

# User Stories

## As a user, I can...

* create a room on the fly
* Send links to a room
* Enter into an existing room
* [Mute my microphone](https://stackoverflow.com/questions/35512314/how-to-mute-unmute-mic-in-webrtc)
* Turn my video off

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

# Channels

* Session
