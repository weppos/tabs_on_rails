#--
# Tabs on Rails
#
# A simple Ruby on Rails plugin for creating and managing Tabs.
#
# Copyright (c) 2009-2012 Simone Carletti <weppos@weppos.net>
#++


module TabsOnRails

  class Railtie < Rails::Railtie
    initializer "tabs_on_rails.initialize" do
    end
  end

end

ActiveSupport.on_load(:action_controller) do
  include TabsOnRails::ActionController
end
