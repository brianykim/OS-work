var http = require('http');

var server = http.createServer(function(req,res) {
    res.write("Yo")
});

server.listen(8000);