const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  // Определяем путь к запрашиваемому файлу
  let filePath = path.join(__dirname, req.url === '/' ? 'index.html' : req.url);
  
  // Проверяем, существует ли файл, и отдаём его
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end('404 Not Found');
      return;
    }
    res.writeHead(200);
    res.end(data);
  });
});

// Слушаем на всех интерфейсах (0.0.0.0) и порту 3000
server.listen(3000, '0.0.0.0', () => {
  console.log('Server running at:');
  console.log('http://localhost:3000/');
  // Получаем локальный IP для удобства
  const os = require('os');
  const ifaces = os.networkInterfaces();
  Object.keys(ifaces).forEach(ifname => {
    ifaces[ifname].forEach(iface => {
      if (iface.family === 'IPv4' && !iface.internal) {
        console.log(`http://${iface.address}:3000/`);
      }
    });
  });
});