module Jekyll
	class InputTag < Liquid::Tag
		def initialize(name,text,tokens)
			super
			@text = text
			@name = name
		end

		def render(context)
			#PARSE THE TEXT, AND OUTPUT THE HTML
			#EVERYTHING CAN BE DONE WITH CUSTOM LIQUID TAGS, EVEN METHODS???, nah
			#BUT HOW TO MATCH WITH THE METHOD.... FUUUUU can't do it from YAML can I?
		end
	end
end

Liquid::Template.register_tag("inputs",Jekyll::InputTag)