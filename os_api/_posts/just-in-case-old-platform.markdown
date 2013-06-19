---
layout: post
title:  "Platform"
categories: "jekyll update"
resources: 
  - 
    methods: 
      - get "/mine"
    name: accounts
  - 
    name: ad_formats
  - 
    name: ad_macros
---

{% resource %}
resource :accounts do
{% endresource %}



{% method accounts %}
      get "/mine" do

{% comment %}
#some sort of description or overview? maybe input tags... idk O_O
{% endcomment %}

        output = Account.active.find(current_account.id)
        output
      end
{% endmethod %} 
{% inputs_tag firstparam,description 1:2ndparam,description 2 can be something like oh this parameter works this way %}
#EXAMPLE REQUEST
{% highlight ruby %}
 return get('api.dev.onescreen.net/v2/accounts/mine')
{% endhighlight %}

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}
{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}



{% resource %}
resource :ad_formats do
{% endresource %}


###Attributes
Check out the [Jekyll docs][jekyll] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll's GitHub repo][jekyll-gh].

[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
