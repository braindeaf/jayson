module Jayson
  module Controller
    extend ActiveSupport::Concern

    included { after_action :jsonp_callback }

    private

    def jsonp_callback
      if request.get? && params[:callback] && params[:format] == 'json'
        response['Content-Type'] = 'application/javascript'
        response.body = "%s(%s)" % [params[:callback], response.body]
      end
    end
  end
end
