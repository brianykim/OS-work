module Jekyll
	class APITag < Liquid::Tag
		def initialize(name,text,tokens)
			super
			@text=text
		end
		def render(context)
			"#{@text} #{Time.now}"
		end

	end
end
 Liquid::Template.register_tag('render_time',Jekyll::APITag)
 #with the text, I can do stuff like, can I split the text into a hash, parse the text by looking for a ":" and then the lines after can be split into instances into the hash?