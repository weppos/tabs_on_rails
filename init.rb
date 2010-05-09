require 'tabs_on_rails'

ActionController::Base.send :include, TabsOnRails::ControllerMixin

Rails.logger.info("** TabsOnRails: initialized properly") if defined?(Rails)
