module Jekyll
	class MethodBlock < Liquid::Block
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
			@text=@text.strip
			
			words = super
			#YOU CAN PARSE TEXT
		
			output=""
			outside=words.lines.to_a.at(1) #NOT THE FIRST???
			chopit=outside.strip
			shown=chopit.chomp(" do")
			bases=shown.split()
			base=bases.at(1)
			base.slice!(0)
			base=base.chomp("\"")
			output+="<h1 class = 'method' style = 'font-family:Helvetica,sans-serif;font-size:300%;'>#{shown}</h1>"
			"#{output}"
			"<h1 class = 'url'>Resource URL</h1>"
			"RESOURCE URL IS: api.dev.onescreen.net/v2/#{@text}/#{shown}"


			#{HOW TO GET TO THE TEXT IN BETWEEN THE BLOCK TAGS???}"#{@text}"

			#HERE WE SAY IGNORE IF THE TAG NAME IS ONE THING, OR GO IF IT'S ANOTHER
		end
	end
end

Liquid::Template.register_tag('method',Jekyll::MethodBlock)