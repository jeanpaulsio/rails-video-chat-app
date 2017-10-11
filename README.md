# Rails Video Chat App

![WebRTC on Rails](https://cdn-images-1.medium.com/max/2000/1*pwyh-wJ4clwB3s4eOXHjqw.jpeg)

[https://webrtc-on-rails.herokuapp.com](https://webrtc-on-rails.herokuapp.com)

# TODO

- [ ] __WebRTC Support across different browsers__
- [ ] Test coverage for WebRTC JS stuff
- [ ] Front End UI
- [ ] Figure Out TurboLinks stuff
- [ ] Create system tests
- [ ] Create API + API tests
- [ ] Error handling for non-existent pages (web + api level)
- [ ] Copy link to clipboard
- [ ] When ICE Servers cant be fetched, I get a nice error - maybe put this in a begin/rescue

```
SocketError in RoomsController#show


Failed to open TCP connection to global.xirsys.net:443 (getaddrinfo: nodename nor servname provided, or not known)

```

# Bugs

* test to make sure the correct link is given in the flash notice. when a user enters a room with a password, they get a link like this:

```
Invite by sharing this link: http://localhost:3000/rooms/room-name?password=%242a%2410%24wTA2KjtiC8Q17%2FskRUODFuRjekAVr3P.53i4lzS.19l.lhiuFyaXK
```

## As a user, I can...

- [x] create a room on the fly
- [x] Enter into an existing room
- [ ] __[Mute my microphone](https://stackoverflow.com/questions/35512314/how-to-mute-unmute-mic-in-webrtc)__
- [ ] __Turn my video off__

## As a guest, I can...

- [x] __Create temporary rooms that expire in 24 hours__ (rake task)
- [x] "register now to claim this room"

## As a member, I can...

- [x] Claim a room name
- [x] __Password protect my room - some kind of authorization__
- [ ] __Choose a brand color for room__

---

# API

[Authentication Using Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth)

# Users

## Registration

__POST__ Endpoint:

```
https://webrtc-on-rails.herokuapp.com/api/v1/auth
```

Request Body:

```json
{
  "email": "kramer@rails.com",
  "password": "foobar",
  "password_confirmation": "foobar"
}
```

200 - Response Body:

```json
{
    "status": "success",
    "data": {
        "id": 1,
        "email": "kramer@rails.com",
        "provider": "email",
        "uid": "kramer@rails.com",
        "created_at": "2017-10-06T05:22:49.774Z",
        "updated_at": "2017-10-06T05:22:49.998Z"
    }
}
```

200 - Response Headers:
__(these must be passed along every authenticated request)__

```
access-token → fdBnuoN8VtlOLLW-cKB58Q
token-type   → Bearer
client       → ucLUd-EIkM-ETYLWFSIL4w
expiry       → 1508475926
uid          → kramer@rails.com
```

422 - Response Body:

```json
{
    "status": "error",
    "data": {
        "id": null,
        "email": "kramer@rails.com",
        "created_at": null,
        "updated_at": null,
        "provider": "email",
        "uid": "kramer@rails.com"
    },
    "errors": {
        "email": [
            "has already been taken"
        ],
        "full_messages": [
            "Email has already been taken"
        ]
    }
}
```

## Signing In

POST Endpoint:

```
https://webrtc-on-rails.herokuapp.com/api/v1/auth/sign_in
```

Request Body:

```json
{
  "email": "kramer@rails.com",
  "password": "foobar"
}
```

200 - Response Body:

```json
{
    "data": {
        "id": 1,
        "email": "kramer@rails.com",
        "provider": "email",
        "uid": "kramer@rails.com"
    }
}
```

200 - Response Headers:
__(these must be passed along every authenticated request)__

```
access-token → fdBnuoN8VtlOLLW-cKB58Q
token-type   → Bearer
client       → ucLUd-EIkM-ETYLWFSIL4w
expiry       → 1508475926
uid          → kramer@rails.com
```

401 - Response Body:

```json
{
    "errors": [
        "Invalid login credentials. Please try again."
    ]
}
```
