require 'rubygems'
require 'json'
require 'neography'

Neography.configure do |config|
	config.protocol = "http://"
	config.server = "localhost"
	confit.port = 7474
	config.directory = ""
	config.cypher_path ="/cypher"
	config.gremlin_path = "/ext/GremlinPlugin/graphdb/execute_script"
	config.log_file = "noegraphy.log"
	config.log_enabled = false
	config.max_threads = 20
	config.authentication = nil
	config.username = nil
	config.passowrd = nil
	config.parser = MultiJsonParser
end

@neo = Neography::Rest.new
node1 = @neo.create_node("age"=>18, "name" => "Brian")
node2 = @neo.create_node("age"=>25, "name" => "Nemo")
@neo.set_node_properties(node1, {"company" => "OneScreen"})

@neo.create_relationship("works_with",node1,node2)

@neo.get_node_relationships(node2, "in", "works_with")

@neo.add_node_to_index("people", "name", "max". node1)
@neo.get_node_index("people","name", "max")

@neo.execute_query("start n=node(0) return n")

@neo.batch [:create_node, {"name" => "Brian"}], [:create_node, {"name"=>"Nemo"}]


#can use node.neo_id or node.name

n1=Neography::Node.create("age"=> 31, "name"=> "Brian")

n1.exist? # => true

n1[:age] #=>31
n1.name # => Brian

n1.weight = 200 # new propeorty
n1[:age] = 18 #change propeorty
n1.age = nil # delete a property

new_Rel = Neography::Relationship.create(:coding_buddies,n1,node2)
new_rel.del
n1.outgoing(:coding_buddies) << node2
n1.outgonig(:friends)
n1.outgoing(:friends).depth(2).include_start_node #node 1 and friends + friends of friends
n1.rel?(:outgoing, :friends) #does it have outgoing friends relationships
n1.rels(:friends,:work).outgoing #get outgoing firends and work relatoinships

n1.all_paths_to(n2).incoming(:friends).depth(4)
n1.shortest_path_to(n2).incoming(:friends).depth(4).nodes


#where string will have the contents of each unique account info
#JSON.parse(string)
#split by line breaks???
#RUBY.LINES, 
#FOR LINE IN LINES
#STRING = LINE
#JSON.PARSE