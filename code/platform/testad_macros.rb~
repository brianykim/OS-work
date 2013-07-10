module OneScreen

  class PLATFORM < Grape::API
#{% resource ad_macros %}
    resource :ad_macros do

      before do
        authenticate!
        check_permission!
        AdMacro.reset_serializations!
      end
#{% method name: /, description: here we go!, resource_url: www.api.dev.onescreen.com/v2/ad_formats/ %}
      get "/" do
        output = AdMacro.scoped
        output = output.paginate(paginate_params).sorting(sort_params)
        output = output.by_version(params[:version]) if params[:version]
        output
      end

      get "/:id" do
        output = AdMacro.find(params[:id])
        output
      end

    end

  end

end
