module Jekyll
	class ClassBlock < Liquid::Block
		include Liquid::StandardFilters
		def initialize(name,text,tokens)
			super
		end
		def render(context)
			#NEED TO TAKE AWAY CLASS NAME
			@text=super
			array = @text.split('&lt')
			firstpart=array.first
			secondpart=array.at(1) #GRAPE API PART
			result=firstpart.split #[CLASS, CLASS_NAME]
			primer=result.at(1)#CLASS NAME
			@text=@text.strip
			@text=@text.chomp(".rb")
			#store the grape api stuff somewhere??? or nahhhh PROBABLY Not
			#HERE MAKE TEXT TO EQUAL JUST THE CLASS...
			"<h1 id='#{primer}'>class #{primer}</h1>"
			#{}"#{@text}"
		end
	end
end

Liquid::Template.register_tag('class_name',Jekyll::ClassBlock)