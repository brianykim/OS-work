module OneScreen

  class PLATFORM < Grape::API

    resource :inventories do

#{% resource Inventories: Use to encapsulate multiple applications to target in a campaign. %}

      before do
        authenticate!
        check_permission!
        Inventory.reset_serializations!
        Widget.reset_serializations!
      end

=begin
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
=end
      get "/" do
        output = params[:query].nil? ? Inventory.scoped : Inventory.tire_search(params)
        output = output.paginate(paginate_params).sorting(sort_params)
        output = output.where(:inventory_type => params[:inventory_type]) unless params[:inventory_type].blank?
        output = output.search_labels(params[:labels]) unless params[:labels].blank?
        output = output.marketplace_state(params[:state]) unless params[:state].blank?
        output = output.not_deleted.owner(current_user.account_id)

        if params[:include_widgets]
          output = output.includes(:widgets)
          Inventory.serialization_include(:widgets)
        end

        if params[:include_labels]
          output = output.includes(:inventory_labels)
          Inventory.serialization_include(:labels)
        end

        output
      end

=begin
{% method %}
name: GET "/inventories/:id";
description: Returns requested inventory by ID;
inputs: id- integer- Inventory ID number;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret. Need to owner of inventory;
{% endmethod %}
=end
      get "/:id" do
        Inventory.serialization_include(:widgets, :labels)
        output = Inventory.not_deleted.owner(current_user.account_id)
        output = output.find(params[:id])
        output
      end

=begin
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
=end
      post "/" do
        inventory = params[:inventory]

        # Create Inventory
        output = Inventory.new(inventory)
        output.account_id = current_user.account_id
        output.user_id = current_user.id
        output.save!

        # Create inventory in adserver
        output.create_adserver_inventory(current_user.id)

        output
      end

      put "/add_labels" do
        inventory_ids = params[:inventory_ids]
        labels = params[:labels]
        output = []
        inventory_ids.each do |inventory_id|
          inventory = Inventory.not_deleted.owner(current_account.id).where(:id => inventory_id)
          if inventory and !inventory.empty?
            inventory = inventory.first
            output << inventory
            labels.each do |label|
              # First check if label exists
              inventory_label = InventoryLabel.where(:account_id => current_account.id, :name => label).first
              if inventory_label.nil?
                # Create label and attach to inventory join table
                inventory_label = InventoryLabel.new(:name => label)
                inventory_label.account_id = current_account.id
                inventory_label.user_id = current_user.id
                inventory_label.save
                LabelsInventory.create(:inventory_id => inventory.id, :inventory_label_id => inventory_label.id)
              else
                relationship = LabelsInventory.where(:inventory_id => inventory.id, :inventory_label_id => inventory_label.id).first
                if relationship.nil?
                  LabelsInventory.create(:inventory_id => inventory.id, :inventory_label_id => inventory_label.id)
                end
              end
            end

            # Handle auditing
            if Inventory.audit_enabled
              inventory.user_id = current_user.id
              inventory.skip_audit = true
              inventory.save
              inventory.create_association_audit(:labels, labels, :added)
            end
          end
        end
        output
      end

      put "/remove_labels" do
        inventory_ids = params[:inventory_ids]
        labels = params[:labels]
        output = []
        inventory_ids.each do |inventory_id|
          inventory = Inventory.not_deleted.owner(current_account.id).where(:id => inventory_id)
          if inventory and !inventory.empty?
            inventory = inventory.first
            output << inventory
            labels.each do |label|
              # First check if label exists and then if it does make sure you remove the label relationship
              inventory_label = InventoryLabel.where(:account_id => current_account.id, :name => label).first
              unless inventory_label.nil?
                relationship = LabelsInventory.where(:inventory_id => inventory.id, :inventory_label_id => inventory_label.id).first
                relationship.destroy if relationship
              end
            end

            # Handle auditing
            if Inventory.audit_enabled
              inventory.user_id = current_user.id
              inventory.skip_audit = true
              inventory.save
              inventory.create_association_audit(:labels, labels, :removed)
            end
          end
        end
        output
      end

=begin
{% method %}
name: PUT "/inventories/:id";
description: Updates and return inventory by ID;
inputs: id- integer- Inventory ID number |
name- string- (Optional) Updated inventory name;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret. Need to owner of inventory;
{% endmethod %}
=end
      put "/:id" do
        Inventory.serialization_include(:widgets)
        inventory = params[:inventory]
        inventory.delete(:id)
        inventory.delete(:is_deleted) # cannot undelete

        # Update Inventory
        output = Inventory.not_deleted.owner(current_user.account_id)
        output = output.find(params[:id])
        output.update_attributes(inventory)
        output.user_id = current_user.id
        output.save!

        output
      end

=begin
{% method %}
name: DELETE "/inventories/:id";
description: Deletes requested inventory;
inputs: id- integer- Inventory ID number;
resource: inventories;
version: 2.0;
permission: Public with API Key/Secret. Need to owner of inventory;
{% endmethod %}
=end
      delete "/:id" do
        output = Inventory.not_deleted.owner(current_user.account_id)
        output = output.find(params[:id])
        raise "Cannot delete inventory yet" if output.widgets.length > 0

        output.is_deleted = true
        output.user_id = current_user.id
        output.save!

        # Notify bridge
        output.delete_adserver_inventory(current_user.id)
        {}
      end

    end

  end

end
