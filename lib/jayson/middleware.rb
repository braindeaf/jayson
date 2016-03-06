module Jayson
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      if headers['Content-Type'] =~ /^application\/json/
        begin
          obj = JSON.parse(response.body)
          pretty_str = JSON.pretty_unparse(obj)
          response = [pretty_str]
          headers['Content-Length'] = pretty_str.bytesize.to_s
        rescue JSON::ParserError => e
        end
      end
      [status, headers, response]
    end
  end
end