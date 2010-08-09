#
# = Tabs on Rails
#
# A simple Ruby on Rails plugin for creating and managing Tabs.
#
#
# Category::    Rails
# Package::     TabsOnRails
# Author::      Simone Carletti <weppos@weppos.net>
# License::     MIT License
#
#--
#
#++


module TabsOnRails

  if defined? Rails::Railtie
    require "rails"

    class Railtie < Rails::Railtie
      initializer "tabs_on_rails.initialize" do
        ActiveSupport.on_load :action_controller do
          TabsOnRails::Railtie.init
        end
      end
    end

  end

  class Railtie

    def self.rails_version
      @@rails_version ||= Rails::VERSION::STRING rescue "2.2"
    end

    def self.init
      ActionController::Base.send :include, TabsOnRails::ControllerMixin
    end

  end

end
