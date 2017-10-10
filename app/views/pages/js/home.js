window.onload = function() {
  var goToRoomForm = document.getElementById("goToRoomForm");
  goToRoomForm.classList.add("d-none");
};

function toggleForm() {
  var createRoomForm = document.getElementById("createRoomForm");
  var goToRoomForm = document.getElementById("goToRoomForm");
  createRoomForm.classList.toggle("d-none");
  goToRoomForm.classList.toggle("d-none");
}

function joinRoom() {
  var roomName = document.getElementById("roomName").value
  if (roomName === "") return alert('You must enter a room name!');
  window.location = "/rooms/" + roomName
}
