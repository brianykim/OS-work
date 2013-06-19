---
layout: post
categories: jekyll update
title: "Platform"
resources:
  -
    methods:
      - get "/mine"
      - get "/shared"
      - get "/audits"
      - get "/categories"
      - put "/add_categories"
      - put "/remove_categories"
      - get "/encoder_policies"
      - put "/add_encoder_policies"
      - put "/remove_encoder_policies"
      - put "/:id"
    name: accounts
  -
    methods:
      - get "/"
      - get "/:id"
    name: ad_macros
---

module OneScreen

{% class_name %}
  class PLATFORM < Grape::API
{% endclass_name %}

{% resource %}
    resource :accounts do
{% endresource %}

      before do 
        authenticate!
        check_permission!
        Account.reset_serializations!
{% comment %}
      end
{% endcomment %}
{% method accounts %}
      get "/mine" do
{% comment %}
#some sort of description or overview? maybe input tags... idk O_O
{% endcomment %}
        output = Account.active.find(current_account.id)
        output
      end
{% endmethod %}
{% method accounts %}
      get "/shared" do
        output = Account.active.find(current_account.id)
        output.shared_accounts
      end
{% endmethod %}

{% method accounts %}
      get "/audits" do
        output = Account.active.find(current_account.id)
        output.audits
      end
{% endmethod %}

{% method accounts %}
      get "/categories" do
        output = Account.active.find(current_account.id)
        output.categories.active
      end
{% endmethod %}

{% method accounts %}
      put "/add_categories" do
        output = []
        category_ids = params[:category_ids]
        category_ids.each do |cid|
          output << Category.find(cid)
          relationship = AccountsCategory.where(:account_id => current_account.id, :category_id => cid).first
          if relationship
            relationship.is_active = true
            relationship.save
          else
            AccountsCategory.create(:account_id => current_account.id, :category_id => cid, :is_system => false)
          end
        end

{% comment %}
      # Handle auditing
{% endcomment %}

        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:categories, category_ids, :added)
        end

        output
      end
{% endmethod %}

{% method accounts %}
      put "/remove_categories" do
        output = []
        category_ids = params[:category_ids]
        category_ids.each do |cid|
          output << Category.find(cid)
          relationship = AccountsCategory.where(:account_id => current_account.id, :category_id => cid).first
          if relationship
            if relationship.is_system
              relationship.is_active = false
              relationship.save
            else
              relationship.destroy
            end
          end
        end
{% comment %}
        # Handle auditing
{% endcomment %}

        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:categories, category_ids, :removed)
        end

        output
      end
{% endmethod %}

{% method accounts %}
      get "/encoder_policies" do
        output = Account.active.find(current_account.id)
        output.encoder_policies
      end
{% endmethod %}

{% method accounts %}
      put "/add_encoder_policies" do
        output = []
        policy_ids = params[:policy_ids]
        policy_ids.each do |pid|
          output << EncoderPolicy.find(pid)
          relationship = AccountsEncoderPolicy.where(:account_id => current_account.id, :encoder_policy_id => pid).first
          AccountsEncoderPolicy.create(:account_id => current_account.id, :encoder_policy_id => pid) unless relationship
        end

{% comment %}
        # Handle auditing
{% endcomment %}
        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:encoder_policies, policy_ids, :added)
        end

        output
      end
{% endmethod %}

{% method accounts %}
      put "/remove_encoder_policies" do
        output = []
        policy_ids = params[:policy_ids]
        policy_ids.each do |pid|
          output << EncoderPolicy.find(pid)
          relationship = AccountsEncoderPolicy.where(:account_id => current_account.id, :encoder_policy_id => pid).first
          relationship.destroy if relationship
        end

{% comment %}
        # Handle auditing
{% endcomment %}
        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:encoder_policies, policy_ids, :removed)
        end

        output
      end
{% endmethod %}

{% method accounts %}
      put "/:id" do
        Account.serialization_include(:redirector_settings) if params[:include_redirector_settings]

        account = params[:account]

{% comment %}
        # Check if account alias is provided
{% endcomment %}
        account_alias = account.delete(:account_alias)

{% comment %}
        # Check if redirector settings are provided
{% endcomment %}
        redirector_settings = account.delete(:redirector_settings)

{% comment %}
        # Load account to edit
{% endcomment %}
        output = Account.active.find(params[:id])

{% comment %}
        # Validate that current requester is the account that is being updated
{% endcomment %}
        raise InvalidRequest.new("Permission issue.") if output.id != current_account.id

{% comment %}
        # Handle redirector settings
{% endcomment %}
        if redirector_settings
          if existing_redirector_settings = RedirectorAccountSetting.where(:account_id => current_account.id).limit(1).first
            existing_redirector_settings.update_attributes(redirector_settings)
          else
            redirector_settings[:account_id] = current_account.id
            RedirectorAccountSetting.create(redirector_settings)
          end
        end
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
        output.attributes = account
        output.user_id = current_user.id
        output.save
{% comment %}
        # response
{% endcomment %}
        output
      end
{% endmethod %}

{% comment %}
    end
{% endcomment %}

{% comment %}
  end
{% endcomment %}

{% comment %}
end
{% endcomment %}
module OneScreen

{% class_name %}
  class PLATFORM < Grape::API
{% endclass_name %}

{% resource %}
    resource :ad_macros do
{% endresource %}

      before do
        authenticate!
        check_permission!
        AdMacro.reset_serializations!
{% comment %}
      end
{% endcomment %}

{% method ad_macros %}
      get "/" do
        output = AdMacro.scoped
        output = output.paginate(paginate_params).sorting(sort_params)
        output = output.by_version(params[:version]) if params[:version]
        output
      end
{% endmethod %}

{% method ad_macros %}
      get "/:id" do
        output = AdMacro.find(params[:id])
        output
      end
{% endmethod %}

{% comment %}
    end
{% endcomment %}

{% comment %}
  end
{% endcomment %}

{% comment %}
end
{% endcomment %}

