const http = require('http');
const fs = require('fs');

http.createServer((req, res) => {
    fs.readFile('index.html', (err, data) => {
        res.end(data.toString());
    });
}).listen(3000);
