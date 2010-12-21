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

require 'tabs_on_rails'
require 'action_controller/base'

module TabsOnRails

  class Railtie < ::Rails::Railtie
    initializer "tabs_on_rails.initialize" do
      ActiveSupport.on_load :action_controller do
        ActionController::Base.send :include, TabsOnRails::ControllerMixin
      end
    end
  end

end
