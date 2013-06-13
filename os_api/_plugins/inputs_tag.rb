module Jekyll
	class InputTag < Liquid::Tag
		def initialize(name, text, tokens)
			super
			@text = text
			@name = name
		end
		def render(context)
			output ="<h1>INPUTS</h1>"
			inputs = @text.split(':')
			output += "<table id='paras' border ='1'>"
			#MAKE A DATA TABLE HERE
			inputs.each do |input|
				what=input.to_s
				output+="<tr>"
				inside = what.split(",")
				for side in inside
					huh=side.to_s()
					output+="<td>#{huh}</td>"
				end
				output+="</tr>"
			end
			output+="</table>"
			"#{output}"
			#EVERYTHING CAN BE DONE WITH CUSTOM LIQUID TAGS, EVEN METHODS???, nah
			#BUT HOW TO MATCH WITH THE METHOD.... FUUUUU can't do it from YAML can I?
		end
	end
end
Liquid::Template.register_tag('inputs_tag',Jekyll::InputTag)
#http://api.dev.onescreen.net