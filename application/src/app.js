// Simple NodeJS application

var http = require('http');

var server = http.createServer(function (request, response) {
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end("Hello World\n");
});

var port = 8080;
var host = "127.0.0.1";

server.listen(port, host);
console.log("Server running at http://"+ host + ":" + port);
