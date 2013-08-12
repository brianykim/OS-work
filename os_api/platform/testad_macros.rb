module OneScreen

  class PLATFORM < Grape::API
#{% resource ad_macros: what what WHAT what %}
    resource :ad_macros do

      before do
        authenticate!
        check_permission!
        AdMacro.reset_serializations!
      end
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
