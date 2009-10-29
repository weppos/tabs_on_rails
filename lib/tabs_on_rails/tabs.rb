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


require 'tabs_on_rails/tabs/builder'
require 'tabs_on_rails/tabs/tabs_builder'


module TabsOnRails

  class Tabs

    def initialize(context, options = {}, &block)
      @context = context
      @builder = (options.delete(:builder) || TabsBuilder).new(@context, options)
    end
    
    %w(open_tabs close_tabs).each do |method|
      define_method(method) do |*args|
        @builder.send(method, *args)
      end
    end
    
    def method_missing(*args)
      @builder.tab_for(*args)
    end
    
  end

end