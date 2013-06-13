module OneScreen

  class PLATFORM < Grape::API

    resource :accounts do

      before do 
        authenticate!
        check_permission!
        Account.reset_serializations!
      end
      get "/mine" do
        output = Account.active.find(current_account.id)
        output
      end
      get "/shared" do
        output = Account.active.find(current_account.id)
        output.shared_accounts
      end

      get "/audits" do
        output = Account.active.find(current_account.id)
        output.audits
      end

      get "/categories" do
        output = Account.active.find(current_account.id)
        output.categories.active
      end

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

      # Handle auditing

        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:categories, category_ids, :added)
        end

        output
      end

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
        # Handle auditing

        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:categories, category_ids, :removed)
        end

        output
      end

      get "/encoder_policies" do
        output = Account.active.find(current_account.id)
        output.encoder_policies
      end

      put "/add_encoder_policies" do
        output = []
        policy_ids = params[:policy_ids]
        policy_ids.each do |pid|
          output << EncoderPolicy.find(pid)
          relationship = AccountsEncoderPolicy.where(:account_id => current_account.id, :encoder_policy_id => pid).first
          AccountsEncoderPolicy.create(:account_id => current_account.id, :encoder_policy_id => pid) unless relationship
        end

        # Handle auditing
        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:encoder_policies, policy_ids, :added)
        end

        output
      end

      put "/remove_encoder_policies" do
        output = []
        policy_ids = params[:policy_ids]
        policy_ids.each do |pid|
          output << EncoderPolicy.find(pid)
          relationship = AccountsEncoderPolicy.where(:account_id => current_account.id, :encoder_policy_id => pid).first
          relationship.destroy if relationship
        end

        # Handle auditing
        if Account.audit_enabled
          account = Account.active.find(current_account.id)
          account.user_id = current_user.id
          account.skip_audit = true
          account.save
          account.create_association_audit(:encoder_policies, policy_ids, :removed)
        end

        output
      end

      put "/:id" do
        Account.serialization_include(:redirector_settings) if params[:include_redirector_settings]

        account = params[:account]

        # Check if account alias is provided
        account_alias = account.delete(:account_alias)

        # Check if redirector settings are provided
        redirector_settings = account.delete(:redirector_settings)

        # Load account to edit
        output = Account.active.find(params[:id])

        # Validate that current requester is the account that is being updated
        raise InvalidRequest.new("Permission issue.") if output.id != current_account.id

        # Handle redirector settings
        if redirector_settings
          if existing_redirector_settings = RedirectorAccountSetting.where(:account_id => current_account.id).limit(1).first
            existing_redirector_settings.update_attributes(redirector_settings)
          else
            redirector_settings[:account_id] = current_account.id
            RedirectorAccountSetting.create(redirector_settings)
          end
        end
#{% comment %}
# # Handle account_alias provided
# if !account_alias.blank? and account_alias != output.account_alias
# new_alias = Account.uniquify_account_alias(account_alias)
# account.merge!(:account_alias => new_alias)
# elsif !account_alias.blank? and account_alias == output.account_alias
# # do nothing...continue
# elsif output.account_alias.blank?
# new_alias = Account.uniquify_account_alias(output.organization)
# account.merge!(:account_alias => new_alias)
# end
#{% endcomment %}
        # Update the database
        output.attributes = account
        output.user_id = current_user.id
        output.save
        # response
        output
      end

    end

  end

end