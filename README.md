# Rails Video Chat App

[https://webrtc-on-rails.herokuapp.com](https://webrtc-on-rails.herokuapp.com)

# TODO

- [ ] Front End UI
- [ ] Create system tests
- [ ] Test coverage for WebRTC JS stuff
- [x] Add Concept of a 'Guest User'
- [ ] __WebRTC Support across different browsers__
- [ ] Document API

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
- [ ] __Password protect my room - some kind of authorization__
- [ ] __upload a brand "logo" to customize__
- [ ] __change page background color__

---

# API

## Authentication

[Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth)

Request

```
POST /api/v1/auth/sign_in
```

Body

```json
{
  "email": "kramer@rails.com",
  "password": "foobar"
}
```

200 OK - Response Body

```json
{
    "data": {
        "id": 3,
        "email": "kramer@rails.com",
        "provider": "email",
        "uid": "kramer@rails.com"
    }
}
```

200 OK - Response Headers (these must be passed along every authenticated request)

```
access-token → fdBnuoN8VtlOLLW-cKB58Q
token-type   → Bearer
client       → ucLUd-EIkM-ETYLWFSIL4w
expiry       → 1508475926
uid          → kramer@rails.com
```

401 Unauthenticated

```json
{
    "errors": [
        "Invalid login credentials. Please try again."
    ]
}
```



