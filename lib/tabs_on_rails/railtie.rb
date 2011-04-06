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

  class Railtie < Rails::Railtie
    initializer "tabs_on_rails.initialize" do
    end
  end

end

ActiveSupport.on_load(:action_controller) do
  include TabsOnRails::ActionController
end
