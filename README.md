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
* __[Mute my microphone](https://stackoverflow.com/questions/35512314/how-to-mute-unmute-mic-in-webrtc)__
* __Turn my video off__

## As a guest, I can...

* __Create temporary rooms that expire in 24 hours__
* "register now to claim this room"

## As a member, I can...

* Claim a room name
* __Password protect my room - some kind of authorization__
* __upload a brand "logo" to customize__
* __change page background color__

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
