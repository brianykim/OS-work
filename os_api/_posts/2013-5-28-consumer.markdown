---
layout: post
title: "Consumer"
categories: jekyll update
resources:
  - 
    methods:
      - method
    name: Android
  - 
    methods:
      - method1
    name: IOS
  -
    methods:
    name: Roku
---

#Hi, I am a header!
{% method name: something, description: here we go, resource_url: will this work? %}
      get "/mine" do
#some sort of description or overview? maybe input tags... idk O_O
        output = Account.active.find(current_account.id)
        output
      end
{% render_time Right now it is: %}