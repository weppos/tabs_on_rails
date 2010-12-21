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
    class Railtie < ::Rails::Railtie
      # initializer "tabs_on_rails.initialize" do
      #   ActiveSupport.on_load :action_controller do
      #     ::ActionController::Base.send :include, TabsOnRails::ActionController
      #   end
      # end
    end
  end

end

require "active_support"
require "action_controller"

# There should be a better way to do this!
# I can't rely on Railtie#initializer because TabsOnRails::ActionController
# provides class methods which should be available when the class
# is evaluated.
ActionController::Base.send :include, TabsOnRails::ActionController
