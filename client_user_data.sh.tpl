#!/bin/bash
apt update -y
apt install -y nodejs npm

mkdir -p /opt/ws-client
cat <<EOF > /opt/ws-client/client.js
const WebSocket = require('ws');
const ws = new WebSocket('ws://${server_private_ip}:8080');
ws.on('open', () => {
  console.log('Connected to server');
  ws.send('Hello from EC2 client');
});
ws.on('message', (data) => {
  console.log('Received:', data);
});
EOF

cd /opt/ws-client
npm install ws
node client.js &
