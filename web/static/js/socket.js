// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let name = prompt("Your name?")
let map;
let channel = socket.channel("tracker:lobby", {name: name})

window.channel = channel;

function positionChanged(position) {
  let coords = position.coords;

  channel.push("move", {
    name: name,
    coords: {
      latitude: coords.latitude,
      longitude: coords.longitude
    }
  })

  map.setCenter({lat: coords.latitude, lng: coords.longitude})
}

window.initMap = function() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
  });
}

channel.join()
  .receive("ok", resp => {
    navigator.geolocation.watchPosition(positionChanged);

    console.log("Joined successfully", resp)
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("welcome", resp => {
  console.log(`Welcome! Folks we know about: ${resp.names.join(', ')}`)
})

channel.on("joined", resp => {
  console.log(`${resp.names.join(', ')} has joined`)
})

channel.on("left", resp => {
  console.log(`${resp.names.join(', ')} has left`)
})

channel.on("moved", resp => {
  console.log(`Moved ${resp.name} to ${resp.coords.latitude}, ${resp.coords.longitude}`, resp.coords);
})

export default socket
