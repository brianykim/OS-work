module Jekyll
	class MethodTag < Liquid::Tag
		include Liquid::StandardFilters
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
			@text=@text.strip
			paras=@text.split(", ")
			nam=paras.at(0)
			descript=paras.at(1)
			resurl=paras.at(2)
			nameparts=nam.split(": ")
			descriptionparts=descript.split(": ")
			resourceurlparts=resurl.split(": ")
			name=nameparts.at(1)
			description=descriptionparts.at(1)
			resourceurl=resourceurlparts.at(1)
			output=""
			output+="<h1 id='#{name}'class='method'>#{name}</h1>"
			output+="<h2 class='method_description'>#{description}</h2>"
			output+="<h1 class = 'url' style='border-bottom:2 px solid purple'>Resource URL</h1>"
			output+="#{resourceurl}"
			"#{output}"

			words = super
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

Liquid::Template.register_tag('method',Jekyll::MethodTag)