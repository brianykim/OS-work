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
      end

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

    end

  end

end
