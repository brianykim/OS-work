module Jekyll
	class ResourceTag < Liquid::Tag
		def initialize(name,text,tokens)
			@text=text
			super
		end
		def render(context)
			@text=@text.strip
=begin			words=@text.split
			desired=words.at(1)
			desired.slice!(0)
=end		
			output="&#x20;"	
			output+="<h1 class='resources' id='#{@text}'>#{@text}</h1>"
=begin			output+="&#x20;<table>"
			output+="&#x20;<tr>"
			output+="{% assign @classroom = post.resources %}"
			output+="{% for classy in @classroom %}"
			output+="{% if classy.name == #{@text} %}"
			output+="{% for method in classy.methods %}"
			output+="&#x20;<td><a class='methods' id='{{ method }}' href= '{{ post.url }}"
			output+="/#"
			output+="{{ classy.name }}-{{ method }}'>{{ method }}</a></td>"
			output+="{% endfor %}"
            output+="{% endif %}"
            output+="{% endfor %}"
			output+="</tr>"
			output+="</table>"
=end
			"#{output}"
		end
	end
end

Liquid::Template.register_tag('resource',Jekyll::ResourceTag)