module Jekyll
	class FirstBlock < Liquid::Block
		include Liquid::StandardFilters
		def initialize(name,markup,tokens)
			@text = markup
			@name = name
			@tokens = tokens
			super
		end
		def render(context)
			#in between these tags we can just make every single one pay attention to the markup.
			#if @text.includes?("ignore")
			#end
			#super
			#{HOW TO GET TO THE TEXT IN BETWEEN THE BLOCK TAGS???}"#{@text}"
			#HERE WE SAY IGNORE IF THE TAG NAME IS ONE THING, OR GO IF IT'S ANOTHER
		end
	end
end

Liquid::Template.register_tag('block',Jekyll::FirstBlock)