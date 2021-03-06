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
  -
    methods:
      - GET "/inventories"
      - GET "/inventories/
      - POST "/inventories/
      - PUT "/inventories/
      - DELETE "/inventories/
    name: Inventories
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
{% resource Inventories: Use to encapsulate multiple applications to target in a campaign. %}
{% method %}
name: GET "/inventories";
description: Returns a collection of inventories.
By default, returns the first 25 items, ordered by ID, and sorted in ascending direction;
inputs: query- string- (Optional) Input inventory name or keyword to return only inventories that matches the query |
order_by- string- (Optional) You can order by any of the fields included in an inventory (i.e. ID, name) |
sort_by- string- (Optional) asc or desc |
inventory_type- string- (Optional) Use to return inventories of type player or display_ad |
labels- string- (Optional) Use to return inventories that are associated to the given label |
state- string- (Optional) Use the keyword public or private to get inventories that exist in the marketplace or in private publisher account |
include_widgets- boolean- (Optional) Set to true to include widgets associated to each inventory |
include_labels- boolean- (Optional) Set to true to include labels associated to each inventory;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret;
{% endmethod %}
{% method %}
name: GET "/inventories/:id";
description: Returns requested inventory by ID;
inputs: id- integer- Inventory ID number;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret. Need to owner of inventory;
{% endmethod %}
{% method %}
name: POST "/inventories/:id";
description: Creates inventory;
inputs: id- integer- Inventory ID number |
name- string- Name of inventory |
inventory_type- string- Inventory can either be a "player" or a "display_ad_##x##" (the number should be replaced by the width and height of the display ad - ie display_ad_350x200 |
is_public- boolean- Specifies whether the inventory should be created in the marketplace or in the account's private publisher account;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret. Need to owner of inventory;
{% endmethod %}
{% method %}
name: PUT "/inventories/:id";
description: Updates and return inventory by ID;
inputs: id- integer- Inventory ID number |
name- string- (Optional) Updated inventory name;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret. Need to owner of inventory;
{% endmethod %}
{% method %}
name: DELETE "/inventories/:id";
description: Deletes requested inventory;
inputs: id- integer- Inventory ID number;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret. Need to owner of inventory;
{% endmethod %}
