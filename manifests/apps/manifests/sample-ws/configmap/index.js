const WebSocket = require('ws');
const http = require('http');
const port = 3000;

// HTTP server for health checks
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('WebSocket server is running\n');
});

// WebSocket server
const wss = new WebSocket.Server({ server });

wss.on('connection', (ws) => {
  console.log('Client connected');

  ws.on('message', (message) => {
    console.log(`Received: ${message}`);
    // Echo the message back to the client
    ws.send(`Echo: ${message}`);
  });

  ws.on('close', () => {
    console.log('Client disconnected');
  });

  ws.on('error', (error) => {
    console.error('WebSocket error:', error);
  });

  // Send welcome message
  ws.send('Connected to WebSocket echo server');
});

server.listen(port, '0.0.0.0', () => {
  console.log(`WebSocket server running at ws://0.0.0.0:${port}/`);
});

