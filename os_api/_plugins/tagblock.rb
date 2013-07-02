module Jekyll
	class MethodBlock < Liquid::Block
		def initialize(name,markup,tokens)
			@text = markup
			@name = name
			@tokens = tokens
			#CAN SET OTHER VARIABLES HERE?
			super
		end
		def render(context)
			#in between these tags we can just make every single one pay attention to the markup.
			#if @text.includes?("ignore")
			#end
			#METHOD WILL HAVE, NAME, DESCRIPTION, METHOD

			output=""
			nam=""
			descript=""
			inputs=""
			resurl=""
			res=""
			versionnumber=""
			permission=""
			@text=super
			@text=@text.strip
			paras=@text.split(";\n")
			for para in paras
				para=para.strip
				if para.include? 'name:'
					nam=para
				end
				if para.include? 'description:'
					descript=para
				end
				if para.include? 'parameters:'
					inputs=para
				end
				if para.include? 'resource_url:'
					resurl=para
				end
				if para.include? 'resource:'
					res=para
				end
				if para.include? 'version:'
					versionnumber=para
				end
				if para.include? 'permission:'
					permission=para
				end
				if para.include? 'properties:'
					properties=para
				end
			end
=begin			nam=paras.at(0)
			descript=paras.at(1)
			inputs=paras.at(2)
			resurl=paras.at(3)
			res=paras.at(4)
			versionnumber=paras.at(5)
=end
			resour=res.split(": ")
			source=resour.at(1)
			#DISPLAY THE NAME
			if !nam.empty?
				nameparts=nam.split(": ")
				name=nameparts.at(1)
				nameid=name.slice(name)
				nameid.chomp!("\"")
				nameid.slice!("get ")
				nameid.slice!("post ")
				nameid.slice!("put ")
				nameid.slice!("delete ")
				nameid.slice!("\"")
				nameid.slice!("/")
				nameid.slice!("\\")
				output+="&#x20;<h1 id='#{source}-#{nameid}' class='method'>#{name}</h1>"
			end
			#DISPLAY VERSION NUMBER
			if !versionnumber.empty?
				number=versionnumber.split(": ")
				version=number.at(1)
				output+="&#x20;<p class='version'><strong>API VERSION: </strong>#{version}</p>"
			end
			if !permission.empty?
				permiss=permission.split(": ")
				perm=permiss.at(1)
				output+="&#x20;<p class = 'permission'><strong>Permissions: </strong>#{perm}</p>"
			end
			#DISPLAY DESCRIPTION
			if !descript.empty?
				descriptionparts=descript.split(": ")
				description=descriptionparts.at(1)
				output+="&#x20;<h2 class='method_description'>#{description}</h2>"
			end
			#DISPLAY THE PARAMETERS
			output += "&#x20;<table class='paras'><tr><th>Parameters</th></tr>"
			inputs.slice!(0..11)
			if !inputs.strip.empty?
				inputsparts=inputs.split(" | ")
				inputsparts.each do |input|
					parts=input.split("- ")
					output+="<tr>"
					for part in parts
						word =part.to_s()
						output+="<td>#{word}</td>"
					end
					output+="</tr>"
				end
			else
				"<tr><td>NONE<td></tr>"
			end
			output+="</table>"
			#DISPLAY THE RESOURCE URL
			resourceurlparts=resurl.split(": ")
			resourceurl=resourceurlparts.at(1)
			output+="&#x20;<h1 class = 'resurl' style='border-bottom:2 px solid purple'>Resource URL</h1>"
			output+="&#x20;<p class ='resurllink'>#{resourceurl}</p>"
			output+="&#x20;<div class='interactive' style='display:none'>nothing</div>"
			if name.include? 'get '
				#OUTPUT INTERACTIVE THINGS HERE FOR THE BOX based on parameters and the resource url
				output+=""
			end
			#INTERACTIVE BOXES GO HERE? here we introduce the html, and the elements will be accessed by script.js, set boxes initially to display:none?
			"#{output}"

			#OTHER SECTIONS FOR THIS METHOD WOULD BE....
			#PERMISSIONS? VERSION NUMBER
			#YOU CAN PARSE TEXT
		
=begin			output=""
			outside=words.lines.to_a.at(1) #NOT THE FIRST???
			chopit=outside.strip
			shown=chopit.chomp(" do")
			bases=shown.split()
			base=bases.at(1)
			base.slice!(0)
			base=base.chomp("\"")
			base.slice!(0)
			output+="<h1 id='#{@text}-#{base}' class = 'method' style = 'font-family:Helvetica,sans-serif;font-size:150%;'>#{shown}</h1>"
			output+="\n"
			output+="<h1 class = 'url' style='border-bottom:2 px solid purple'>Resource URL</h1>"
			output+="\n"
			output+="api.dev.onescreen.net/v2/#{@text}/#{base}"

			"#{output}"
=end			#hpricot
			#{HOW TO GET TO THE TEXT IN BETWEEN THE BLOCK TAGS???}"#{@text}"

			#HERE WE SAY IGNORE IF THE TAG NAME IS ONE THING, OR GO IF IT'S ANOTHER
		end
	end
end

Liquid::Template.register_tag('method',Jekyll::MethodBlock)