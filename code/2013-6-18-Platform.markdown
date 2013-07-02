---
layout: post
categories: jekyll update
title: "Platform"
resources:
  -
    methods:
      - get "/mine"
    name: accounts: Description
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
#some sort of description or overview? maybe input tags... idk O_O
{% endcomment %}
{% comment %}
      # Handle auditing
{% endcomment %}
{% comment %}
        # Handle auditing
{% endcomment %}
{% comment %}
        # Handle auditing
{% endcomment %}
{% comment %}
        # Handle auditing
{% endcomment %}
{% comment %}
        # Check if account alias is provided
{% endcomment %}
{% comment %}
        # Check if redirector settings are provided
{% endcomment %}
{% comment %}
        # Load account to edit
{% endcomment %}
{% comment %}
        # Validate that current requester is the account that is being updated
{% endcomment %}
{% comment %}
        # Handle redirector settings
{% endcomment %}
{% comment %}
{% comment %}
# # Handle account_alias provided
{% endcomment %}
{% comment %}
# if !account_alias.blank? and account_alias != output.account_alias
{% endcomment %}
{% comment %}
# new_alias = Account.uniquify_account_alias(account_alias)
{% endcomment %}
{% comment %}
# account.merge!(:account_alias => new_alias)
{% endcomment %}
{% comment %}
# elsif !account_alias.blank? and account_alias == output.account_alias
{% endcomment %}
{% comment %}
# # do nothing...continue
{% endcomment %}
{% comment %}
# elsif output.account_alias.blank?
{% endcomment %}
{% comment %}
# new_alias = Account.uniquify_account_alias(output.organization)
{% endcomment %}
{% comment %}
# account.merge!(:account_alias => new_alias)
{% endcomment %}
{% comment %}
# end
{% endcomment %}
{% endcomment %}
{% comment %}
        # Update the database
{% endcomment %}
{% comment %}
        # response
{% endcomment %}
{% resource ad_macros %}
{% method name: /, description: here we go!, resource_url: www.api.dev.onescreen.com/v2/ad_formats/ %}

