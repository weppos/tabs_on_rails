#--
# Tabs on Rails
#
# A simple Ruby on Rails plugin for creating and managing Tabs.
#
# Copyright (c) 2009-2017 Simone Carletti <weppos@weppos.net>
#++


module TabsOnRails

  class Railtie < Rails::Railtie
    ActiveSupport.on_load(:action_controller) do
      ::ActionController::Base.send(:include, TabsOnRails::ActionController)
    end
  end

end
