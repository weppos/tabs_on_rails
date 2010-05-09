require 'tabs_on_rails'

ActionController::Base.send :include, TabsOnRails::ControllerMixin

RAILS_DEFAULT_LOGGER.info("** TabsOnRails: initialized properly") if defined?(RAILS_DEFAULT_LOGGER)
