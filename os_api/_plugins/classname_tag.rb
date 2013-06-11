module Jekyll
	class ClassTag < Liquid::Tag
		def initialize(name,text,tokens)
			@text = text.strip
		end
		def render(context)
			@text=@text.chomp('.rb')
			"<h1 id='#{@text}'>#{@text}</h1>"
			#{}"#{@text}"
		end
	end
end

Liquid::Template.register_tag('class_name',Jekyll::ClassTag)