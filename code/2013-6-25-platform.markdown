---
layout: post
categories: jekyll update
title: "Platform"
resources:
  -
    methods:
      - get "/mine"
    name:  accounts
  -
    methods:
    name: ad_macros
---
 {% resource accounts: Description %}
{% method %}
name: get "/mine";
description: METHOD DESCRIPTION HERE;
inputs: param1- string- description 1 | param2- int- description 2 | param3- array- what in the world;
resource: accounts;
version: 2.0;
permission: Public with API Key/Secret;
resource_url: www.api.dev.onescreen.com/v2/accounts/mine
{% endmethod %}
{% comment %}
{% endcomment %}
{% resource ad_macros: what what WHAT what %}
{% method name: /, description: here we go!, resource_url: www.api.dev.onescreen.com/v2/ad_formats/ %}
