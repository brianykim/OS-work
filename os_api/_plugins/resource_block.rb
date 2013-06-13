module Jekyll
	class ResourceBlock < Liquid::Block
		def initialize(name,text,tokens)
			super
		end
		def render(context)
			@text=super
			@text=@text.strip
			words=@text.split
			desired=words.at(1)
			desired.slice!(0)
			"<h1 class='resources' id='#{desired}'>#{desired}</h1>"

		end
	end
end

Liquid::Template.register_tag('resource',Jekyll::ResourceBlock)