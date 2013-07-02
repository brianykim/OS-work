module Jekyll
	class FunctionBlock < Liquid::Block
		def intialize(name,markup,tokens)
			@text=markup
			super
		end
		def render(context)
#			split this stuff up into the various JSDOC or RDOC style parameters and parse those and display
		end
	end
end