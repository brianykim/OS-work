module Jekyll
	module Tags
		class FirstBlock < Liquid::Block
			include Liquid::StandardFilters
			def initialize(name,text,tokens)
				@text = text
				@name=name
			end
			def render(context)
				#HERE WE SAY IGNORE IF THE TAG NAME IS ONE THING, OR GO IF IT'S ANOTHER
			end
		end
	end
end

Liquid::Template.register_tag('block',Jekyll::Tags::FirstBlock)