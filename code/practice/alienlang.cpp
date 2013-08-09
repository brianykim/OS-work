#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <fstream>

using namespace std;

int main()
{
	ifstream ifile("input.txt");
	ofstream ofile("output.txt");

	int length, words, cases;
	ifile>>length;
	ifile>>words;
	ifile>>cases;

	vector<string> wordbank;
	for(int i=0; i<words; i++)
	{
		string x;
		ifile>>x;
		wordbank.push_back(x);
	}
	for(int i=1; i<cases+1; i++)
	{
		int ans=0;
		string current;
		ifile>>current;
		int j=0;
		if (current.substring(0,1)=="(")
		{
			vector<string> potents;
			while(current.substring(j,1)!=")")
			{
				potents.push_back(current.substring(j,1));
				j++;
			}
			for(int k=0;k<words.size();k++)
			{
				if(words.at(k).substring(j,1))
			}

		}
		//see how many letters in the parentheses match words, and if ture at end then + that amount?
		ofile<<"Case #"<<i<<": "<<ans<<endl;

	}

}

/*

nodejs index. js

var server = require("./server");
var router = require("./router");
 
server.start(router.route);

but in server.js
create the http server
listen to the ports
and respond to users requests with appropriate response


router
var url = require("url");

function start(route) {
	function on Request(request,response) {
	var pathname = url.parse(request.url).pathname;
	console.log("Request for " + pathname + " received.");

	route(pathname);

	response.writeHead(200, {"Content-Type": "text/plain"});
	response.write("Hello World");
	response.end();
	}

http.createServer(onRequest).listen(8888);
console.log("Server has started");
}

exports.start = start;

node index.js

where server will be a .js file in the same directory

*/