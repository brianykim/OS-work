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