module Jekyll
	class JSFunctionBlock < Liquid::Block
		def initialize(name,text,tokens)
			@text=text
			super
		end
		def render_context(context)
			body=super
			lines=body.lines
			for line in lines
				if line.include? "@param"
					line=line.strip
					lineparts=line.split()

					if line.include? "param"

						#LIST OF THINGS
=begin
LIST OF THINGS WE NEED TO ACCOUNT FOR
CONSTRUCTOR
PARAMS (OPTIONAL VS. REQUIRED, WILL BE IN Value)
@author 	Developer's name
@constructor 	Marks a function as a constructor
@deprecated 	Marks a method as deprecated
@exception 	Synonym for @throws
@param 	Documents a method parameter; a datatype indicator can be added between curly braces
@private 	Signifies that a method is private
@return 	Documents a return value
@see 	Documents an association to another object
@this 	Specifies the type of the object to which the keyword "this" refers within a function.
@throws 	Documents an exception thrown by a method
@version 	Provides the version number of a library


=end
					end
				end
			end

			#find the words that include @tags
			#if they exist, then do them
			
		end
	end
end

Liquid::Template.register_tag('jsfunction',Jekyll::JSFunctionBlock)