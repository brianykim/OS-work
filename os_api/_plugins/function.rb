module Jekyll
	class FunctionBlock < Liquid::Block
		def intialize(name,markup,tokens)
			@text=markup
			super
		end
		def render(context)
			text = super
			output=""
			lines = text.lines
			for line in lines
			
				if line.include? "@param"
					#take the resource name
					output+="<h1>Try out a sample API call for this method</h1>"
					output+="<form name='sample'><input type='text' value='here we go'></input></name>"
					#so automatically generate the url of the call based on what's in these fields...
					#THENNNN, you can use jquery to take the value from the field boxes, and make the ajax call to that url'
					#but how do you access the resource url???? to generate based on query parameters
					#inside the actual resource block that's how...

					#CREATE THE TABLE OF PARAMETERS? how is it formatted though...
					#turn this into a table

				end		
			end

#			split this stuff up into the various JSDOC or RDOC style parameters and parse those and display
		end
	end
end

Liquid::Template.register_tag('function',Jekyll::FunctionBlock)