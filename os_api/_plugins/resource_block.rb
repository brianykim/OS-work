module Jekyll
	class ResourceTag < Liquid::Tag
		def initialize(name,text,tokens)
			@text=text
			super
		end
		def render(context)
			@text=@text.strip
=begin			words=@text.split
			desired=words.at(1)
			desired.slice!(0)
=end			
			"<h1 class='resources' id='#{@text}'>#{@text}</h1>"

		end
	end
end

Liquid::Template.register_tag('resource',Jekyll::ResourceTag)