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
			text = super
			#YOU CAN PARSE TEXT
		
			output=""
			outside=text.lines.to_a.at(1) #NOT THE FIRST???
			chopit=outside.strip
			shown=chopit.chomp(" do")
			output+="<h1 class = 'method'>#{shown}</h1>"
			"#{output}"
			#{HOW TO GET TO THE TEXT IN BETWEEN THE BLOCK TAGS???}"#{@text}"

			#HERE WE SAY IGNORE IF THE TAG NAME IS ONE THING, OR GO IF IT'S ANOTHER
		end
	end
end

Liquid::Template.register_tag('method',Jekyll::MethodBlock)