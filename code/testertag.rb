def render()
	text=gets
=begin	inputs = text.split(':')
	puts "<table border ='1'>"
	#MAKE A DATA TABLE HERE
	inputs.each do |input|
		what=input.to_s
		puts "<tr>"
		inside = what.split(",")
		for side in inside
			huh=side.to_s()
			puts "<td>#{huh}</td>"
		end
		puts "</tr>"
	end
=end	
			puts text
			showthisthing=text.lines.first.strip
            puts showthisthing
			shown=showthisthing.chomp(' do')
			
			puts "<h1 class = 'method'>#{shown}</h1>"
	#EVERYTHING CAN BE DONE WITH CUSTOM LIQUID TAGS, EVEN METHODS???, nah
	#BUT HOW TO MATCH WITH THE METHOD.... FUUUUU can't do it from YAML can I?
end

render()