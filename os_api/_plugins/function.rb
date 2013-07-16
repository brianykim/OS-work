module Jekyll
	class FunctionBlock < Liquid::Block
		def intialize(name,markup,tokens)
			@text=markup
			super
		end
		def render(context)
			text = super
			lines = text.lines
			for line in lines
				if line.include? "@param"
					#CREATE THE TABLE OF PARAMETERS? how is it formatted though...

				end
			end

#			split this stuff up into the various JSDOC or RDOC style parameters and parse those and display
		end
	end
end