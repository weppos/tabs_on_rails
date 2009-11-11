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
    
    %w(open_tabs close_tabs).each do |name|
      define_method(name) do |*args|                      # def open_tabs(*args)
        method = @builder.method(name)                    #   method = @builder.method(:open_tabs)
        if method.arity.zero?                             #   if method.arity.zero?
          message = "Incomplete `#{name}' definition. " + #     ...
            "Use #{name}(*args) to ignore arguments "   + #     ...
            "or #{name}(options) to collect options"      #     ...
          ActiveSupport::Deprecation.warn(message)        #     ...
          method.call                                     #     method.call
        else                                              #   else
          method.call(*args)                              #     method.call(*args)
        end                                               #   end
      end                                                 # end
    end
    
    def method_missing(*args)
      @builder.tab_for(*args)
    end
    
  end

end