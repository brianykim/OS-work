#!/usr/bin/env ruby
require 'json'
require 'neography'

Neography.configure do |config|
	config.protocol = "http://"
	config.server = "localhost"
	config.port = 7474
	config.directory = ""
	config.cypher_path ="/cypher"
	config.gremlin_path = "/ext/GremlinPlugin/graphdb/execute_script"
	config.log_file = "neography.log"
	config.log_enabled = false
	config.max_threads = 20
	config.authentication = nil
	config.username = nil
	config.password = nil
	config.parser = MultiJsonParser
end

def deleteemall
	@neo=Neography::Rest.new
	n=7
	while n<9840
		begin 
			node=@neo.get_node(n)
			rels=@neo.get_node_relationships(node)
			#for rel in rels
			for rel in rels
				@neo.delete_relationship(rel)
			end
			#end
			@neo.delete_node(node)
			n=n+1
		rescue Neography::NodeNotFoundException
			n=n+1
			next
		end
	end
	#delete all nodes
end
deleteemall