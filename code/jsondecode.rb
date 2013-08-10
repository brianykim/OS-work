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

#STRIP [] THEN FIND },{ AND SPLIT BY THE COMMAS, THEN JSON PARSE EACH ONE
def runit
	@neo = Neography::Rest.new
	
	file=File.open("php/output.txt","r")
	lines=IO.readlines(file)
	
	for line in lines
		line.gsub!("\]\[",",")
		line.slice!("[")
		line=line.chomp("]")
		parts=line.split("},")
		parts.last.chomp!("}")
		for part in parts
			part+="}"
			what=JSON.parse(part)
			props=what.keys
			node=@neo.create_node()
			for prop in props
				begin
				if not "#{prop}"==nil and not what["#{prop}"]==nil
					@neo.set_node_properties(node,{"#{prop}" => what["#{prop}"]})
				end
				rescue Neography::PropertyValueException
					next
				end
			end
			#node1=@neo.create_node(what)
			puts what["account_alias"]
		end
		#if there exist similar properties to create relationships... n^2? O_O
	end
end
runit


=begin
	-account_alias
	-address1
	-address2
	-admin_id
	-adserver_account_token_publisher
	-adserver_account_token_advertiser
	agencies_agreement
	aggregators_agreement
	branded_logo_url
	-city
	-country
	-created_at
	deactivated_at
	default_playlist_ttl
	default_video_policy
	-fax
	-has_advertising_access
	-has_publishing_access
	-has_content_access
	-id
	-is_active
	-is_adsever_public
	-marketplace
	-modified_at
	-namespace_account_id
	networks_agreement
	-new_console
	-organization
	-os_account_manager_id
	-os_sales_rep_id
	-owner_account_id
	-passthrough_destination_id
	-passthrough_playlist_id
	-passthrough_widget_id
	-phone
	-podio_item_id
	-postal_code
	-primary_website
	-referer_account_id
	-sponsor_account_id
	sponsored_logo_url
	-state
	tax_identifier
	user_id
	redirector_settings

=end