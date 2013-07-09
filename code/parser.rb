#!/usr/bin/env ruby
def parsing
	directoryname=""
	ARGV.each do |argument|
	  directoryname+= "#{argument}"
	end
	#Contain = Struct.new(:name,:methods)
	directory=Dir.new(directoryname)
	directory.each do |filename|
		File.new("rubyoutput.txt","w")
		output=File.open("rubyoutput.txt","w")
		#to check if comment block has been encountered
		block=false
		#File.open(filename)
		if filename.include? ".rb" and !filename.include?".rb~"

			file=File.open(directoryname+"/"+filename,"r")
			#now onto the actual parsing of the file
			lines=IO.readlines(file)
			for line in lines
				if line.include? "#" and line.include? "{% "
					line.slice!("#")
					output.puts(line)
				else
					if line.include? "=end"
						block=false
					end
					if block
						output.puts(line)
					end
					if line.include? "=begin"
						block=true
						
					end
				end

			end
			puts filename
		end
		if filename.include? ".js" or filename.include? ".java" or filename.include? ".php" or filename.include? ".cpp"

		end
	end
	#need to open up the directory name using Dir and then.... we can start going into parsing using Regexp
	#Dir.foreach(directoryname) do |item|
	#	puts "#{item}"
	#end

	#NEED THE YAML GENERATION
	outname="2013-6-25-"+directoryname+".markdown";
	File.new(outname,"w")
	outdown=File.open(outname,"w")
	outdown.puts("---")
	outdown.puts("layout: post")
	outdown.puts("categories: jekyll update")
	outdown.puts("title: \""+directoryname.capitalize+"\"")
	puts directoryname
	#File.new("rubyoutput.txt")
end

#USE REGEXP TO BE SPECIFIC ENOUGH
#puts /expression/ =~ "How about this expression?"
#slice and chomp the comments out of it
#extract the 
parsing