module Jekyll
	class RubyConverter < Converter
		safe true
		priority :low

		def matches(ext)
			ext =~ /^\.rb$/i 
		end
		
		def output_ext(ext)
			".markdown"
		end

		def convert(content)
		
			#This is a comment?
			#find matches of parser
			#WHILE THE FILE NEEDS TO HAVE YAML FRONT MATTER, it will be ignored...... FUUUUUUUUUUU well that iss pointless and annoying then
			


		end
	end
end
