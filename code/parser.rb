#!/usr/bin/env ruby
def parsing
	directoryname=""
	ARGV.each do |argument|
	  directoryname=""
	  directoryname+= "#{argument}"
	
	#change it so that you can run it on multiple directories by simple including them into the
	#commandline arguments, and output that "so and so"-directory could not be found if such
	#is the case
		container = Hash.new { |hash, key| hash[key] = [] }
		#Contain = Struct.new(:name,:methods)
		if Dir.exists?(directoryname)
			directory=Dir.new(directoryname)

			File.new("rubyoutput.txt","w")
			output=File.open("rubyoutput.txt","w")
			directory.each do |filename|
				
				#to check if comment block been has encountered
				block=false
				liquidblock=false
				#File.open(filename)
				if filename.include? ".rb" and !filename.include?".rb~"

					file=File.open(directoryname+"/"+filename,"r")
					#now onto the actual parsing of the file
					lines=IO.readlines(file)
					resname=""
					for line in lines
						if line.include? "#" and line.include? "{% "
							line.slice!("#")
							if line.include? "{% resource "
								resname=""
								resname+=line
								resname.strip
								resname.slice!("{% resource ")
								resparts=resname.split(":")
								resname=resparts.at(0)
								container[resname]

							end
							output.puts(line)
						else
							if line.include? "{% "
								liquidblock=true
							end
							if line.include? "=end" and not line.include? " =end"
								block=false
							end
							if block and liquidblock
								if line.include? "name:"
									nameline=line
									nameline.strip
									namelineparts=nameline.split(":")
									name=namelineparts.at(1)
									name=name.strip
									name=name.chomp(";")
									container[resname].push(name)
								end
								if line.include? "@name "
									nameline=line
									nameline.strip
									#namelineparts=nameline.split()
									#name=namelineparts.at(1)
									#name=name.strip
								end

								output.puts(line)
							end
							if line.include? "=begin" and not line.include? " begin"
								block=true
								
							end
							if line.include? "{% end"
								liquidblock=false
							end
						end

					end
					#puts filename
				end
				if filename.include? ".js" or filename.include? ".java" or filename.include? ".php" or filename.include? ".cpp"
					file=File.open(directoryname+"/"+filename,"r")
					#now onto the actual parsing of the file
					lines=IO.readlines(file)
					resname=""
					for line in lines
						if line.include? "//" and line.include? "{% "
							line.slice!("//")
							if line.include? "{% resource "
								resname=""
								resname+=line
								resname.strip
								resname.slice!("{% resource ")
								resparts=resname.split(":")
								resname=resparts.at(0)
								container[resname]

							end
							
							output.puts(line)
						else
							if line.include? "{% "
								liquidblock=true
							end

							if line.include? "*/"
								block=false
							end
							if block and liquidblock
								if line.include? "name:"
									nameline=line
									nameline.strip
									namelineparts=nameline.split(":")
									name=namelineparts.at(1)
									name=name.strip
									name=name.chomp(";")
									container[resname].push(name)
								end
								output.puts(line)
							end
							if line.include? "/*"
								block = true
							end
							if line.include? "{% end"
								liquidblock=false
							end
						end
					end

				end
				
			end
			output.close
			#need to open up the directory name using Dir and then.... we can start going into parsing using Regexp
			#Dir.foreach(directoryname) do |item|
			#	puts "#{item}"
			#end

			#NEED THE YAML GENERATION
			outbody=File.open("rubyoutput.txt", "r")
			taglines=IO.readlines(outbody)
			#puts taglines.at(0)
			outname="2013-6-25-"+directoryname+".markdown";
			File.new(outname,"w")
			outdown=File.open(outname,"w")
			outdown.puts("---")
			outdown.puts("layout: post")
			outdown.puts("categories: jekyll update")
			outdown.puts("title: \""+directoryname.capitalize+"\"")
			outdown.puts("resources:")
			#puts directoryname
			
			#puts container
			for key in container.keys
				outdown.puts("  -")
				outdown.puts("    methods:")
				for val in container[key]
					outdown.puts("      - "+val)
				end
				outdown.puts("    name: "+key)
			end
			outdown.puts("---")
			for tagline in taglines
				outdown.puts(tagline)

			end
		else
			puts("I'm sorry, but "+directoryname+" is not a real directory.")
		end
		#File.new("rubyoutput.txt")
	end
end

#USE REGEXP TO BE SPECIFIC ENOUGH
#puts /expression/ =~ "How about this expression?"
#slice and chomp the comments out of it
#extract the 
parsing