#!/usr/bin/env node
var http = require('http');
var app = require('http').createServer(handler);
var io = require('socket.io').listen(app);
var fs = require('fs');
var express = require('express');
var app = express();
app.get('/hello.txt', function(request,response){
	var body = 'Hello World';
	response.setHeader('Content-Type', 'text/plain');
	response.setHeader('Content-Length', body.length);
	response.send('Hello World');
	response.end(body);
});

var MongoClient = require('mongodb').MongoClient;
var format = require('util').format;

MongoClient.connect('mongodb://127.0.0.1:27017/test',function(err,db){
	if(err) throw err;
	var collection = db.collection('test_insert');
	collection.insert({a:2},function(err,docs){
		collection.count(function(err,count) {
			console.log(format("count=%s", count));
		});
		collection.find().toArray(function(err,results) {
			console.dir(results);
			db.close();
		});
	});
});
app.listen(80);
console.log('Listening on port 3000');
function handler (req,res) {
	fs.readFile(_dirname + '/index.html',
	function (err,data) {
		if (err) {
			res.writeHead(500);
			return res.end('Error loading index.html');
		}
		res.writeHead(200);
		res.end(data);
	});
}

io.sockets.on('connection',function (socket){
	socket.emit('news',{hello:'world'});
	socket.on('my other event',function(data){
		console.log(data);
	});
});

listenPort = 3030;


http.createServer(function(req,res) {
	if(req.url == '/') {

		fs.readFile('./hello.html', 'UTF8', function(err,content) {
			if(err) {
				res.writeHead(500);
					res.end("Error:" + err);
				return;
			}
			res.end(content);
		});
	} else {
		res.writeHead(404);
		res.end("File Not Found!");
	}
}).listen(listenPort);

console.log('Listening on port: ' + listenPort);