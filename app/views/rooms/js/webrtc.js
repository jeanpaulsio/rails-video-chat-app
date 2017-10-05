let roomName = document.getElementById("room-name").dataset.room;

window.onload = () => {
  initialize();
};

const initialize = () => console.log("initializing");

const handleJoinSession = async () => {
  App.session = await App.cable.subscriptions.create(
    { channel: "SessionChannel", id: roomName },
    {
      connected: () => {
        broadcastData({ type: "initiateConnection", roomName });
      },
      received: data => {
        console.log("RECEIVED:", data);
      }
    }
  );
};

const broadcastData = data => {
  $.ajax({
    url: "/sessions",
    type: "post",
    data
  });
};
