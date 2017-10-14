document.getElementById("copy-button").addEventListener("click", function(e) {
  e.preventDefault();

  var copied;
  document.getElementById("copy-room-name").select();

  try {
    copied = document.execCommand("copy");
  } catch (e) {
    copied = false;
  }

  if (copied) {
    document.getElementById("copy-button").innerHTML = "Saved to Clipboard!"
  }
});

// Broadcast Types
const JOIN_ROOM = "JOIN_ROOM";
const EXCHANGE = "EXCHANGE";
const REMOVE_USER = "REMOVE_USER";

// DOM Elements
const currentUser = document.getElementById("currentUser").dataset.email;
const selfView = document.getElementById("selfView");
const remoteViewContainer = document.getElementById("remoteViewContainer");
const joinBtnContainer = document.getElementById("join-btn-container");
const leaveBtnContainer = document.getElementById("leave-btn-container");

// Configuration
let roomName = document.getElementById("room-name").dataset.room;
let constraints = { audio: false, video: true };
let xirsysIceCreds;

// Global Objects
let pcPeers = {};
let localStream;

window.onload = () => {
  initialize();
};

const initialize = async () => {
  App.ice = await App.cable.subscriptions.create(
    { channel: "IceChannel", id: roomName },
    {
      received: data => {
        xirsysIceCreds = JSON.parse(data);
        xirsysIceCreds = xirsysIceCreds["v"];
      }
    }
  );

  navigator.mediaDevices
    .getUserMedia(constraints)
    .then(stream => {
      localStream = stream;
      selfView.srcObject = stream;
      selfView.muted = true;
    })
    .catch(logError);
};

const handleJoinSession = async () => {
  App.session = await App.cable.subscriptions.create(
    { channel: "SessionChannel", id: roomName },
    {
      connected: () => connectUser(currentUser),
      received: data => {
        console.log("received", data);
        if (data.from === currentUser) return;
        switch (data.type) {
          case JOIN_ROOM:
            return joinRoom(data);
          case EXCHANGE:
            if (data.to !== currentUser) return;
            return exchange(data);
          case REMOVE_USER:
            return removeUser(data);
          default:
            return;
        }
      }
    }
  );

  joinBtnContainer.style.display = "none";
  leaveBtnContainer.style.display = "block";
};

const handleLeaveSession = () => {
  for (user in pcPeers) {
    pcPeers[user].close();
  }
  pcPeers = {};

  App.session.unsubscribe();

  remoteViewContainer.innerHTML = "";

  broadcastData({
    type: REMOVE_USER,
    from: currentUser,
    roomName
  });

  joinBtnContainer.style.display = "block";
  leaveBtnContainer.style.display = "none";
};

const connectUser = userId => {
  broadcastData({
    type: JOIN_ROOM,
    from: currentUser,
    roomName
  });
};

const joinRoom = data => {
  createPC(data.from, true);
};

const removeUser = data => {
  console.log("removing user", data.from);
  let video = document.getElementById(`remoteView+${data.from}`);
  video && video.remove();
  delete pcPeers[data.from];
};

const createPC = (userId, isOffer) => {
  let pc = new RTCPeerConnection(xirsysIceCreds);
  pcPeers[userId] = pc;
  pc.addStream(localStream);

  isOffer &&
    pc
      .createOffer()
      .then(offer => {
        pc.setLocalDescription(offer);
        broadcastData({
          type: EXCHANGE,
          from: currentUser,
          to: userId,
          sdp: JSON.stringify(pc.localDescription),
          roomName
        });
      })
      .catch(logError);

  pc.onicecandidate = event => {
    event.candidate &&
      broadcastData({
        type: EXCHANGE,
        from: currentUser,
        to: userId,
        candidate: JSON.stringify(event.candidate),
        roomName
      });
  };

  pc.onaddstream = event => {
    const element = document.createElement("video");
    element.id = `remoteView+${userId}`;
    element.autoplay = "autoplay";
    element.srcObject = event.stream;
    remoteViewContainer.appendChild(element);
  };

  pc.oniceconnectionstatechange = event => {
    if (pc.iceConnectionState == "disconnected") {
      console.log("Disconnected:", userId);
      broadcastData({
        type: REMOVE_USER,
        from: userId,
        roomName
      });
    }
  };

  return pc;
};

const exchange = data => {
  let pc;

  if (!pcPeers[data.from]) {
    pc = createPC(data.from, false);
  } else {
    pc = pcPeers[data.from];
  }

  if (data.candidate) {
    pc
      .addIceCandidate(new RTCIceCandidate(JSON.parse(data.candidate)))
      .then(() => console.log("Ice candidate added"))
      .catch(logError);
  }

  if (data.sdp) {
    sdp = JSON.parse(data.sdp);
    pc
      .setRemoteDescription(new RTCSessionDescription(sdp))
      .then(() => {
        if (sdp.type === "offer") {
          pc.createAnswer().then(answer => {
            pc.setLocalDescription(answer);
            broadcastData({
              type: EXCHANGE,
              from: currentUser,
              to: data.from,
              sdp: JSON.stringify(pc.localDescription),
              roomName
            });
          });
        }
      })
      .catch(logError);
  }
};

const broadcastData = data => {
  $.ajax({
    url: "/sessions",
    type: "post",
    data
  });
};

const logError = error => console.warn("Error:", error);
