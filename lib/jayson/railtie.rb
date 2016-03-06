module Jayson
  class Railtie < Rails::Railtie
    initializer 'jayson.action_controller' do
      ActiveSupport.on_load(:action_controller) do
        # ActionController::Base gets a method that allows controllers to include the new behavior
        include Jayson::Controller # ActiveSupport::Concern
      end
    end

    initializer 'jayson.configure_rails_initialization' do
      Rails.application.middleware.use Jayson::Middleware
    end
  end
end