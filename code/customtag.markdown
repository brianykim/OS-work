module Jekyll
	class APITag < Liquid::Tag
{% highlight ruby %}

		def initialize(name,text,tokens)
			super
			@text=text
		end
		def render(context)

			#parsable=@text
			#parsable.split(",") #BUT DO THIS AFTER YOU GET PAST THE ORIGINAL TEXT OF "INPUTS:"" OR RATHER STORE TAHT SOMEWHERE ELSE AND HAVE THAT DISPLAYED?
		"#{@text} #{Time.now}"

			#in here we will parse the text other than the tag into a hash???? not necessarily a data structure needed, but we can format it accordingly?
		end
{% endhighlight %}

	end
end
 Liquid::Template.register_tag('render_time',Jekyll::APITag)
 #with the text, I can do stuff like, can I split the text into a hash, parse the text by looking for a ":" and then the lines after can be split into instances into the hash?
