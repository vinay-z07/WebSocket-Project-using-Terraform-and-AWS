#!/bin/bash
apt update -y
apt install -y nodejs npm

mkdir -p /opt/ws-server
cat <<EOF > /opt/ws-server/server.js
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });
wss.on('connection', function connection(ws) {
  console.log('Client connected.');
  ws.on('message', function incoming(message) {
    console.log('Received:', message);
    ws.send('Echo: ' + message);
  });
  ws.send('Welcome to WebSocket server!');
});
console.log('WebSocket server running on port 8080');
EOF

cd /opt/ws-server
npm install ws
node server.js &
