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

    def initialize(context, options = {})
      @context = context
      @builder = (options.delete(:builder) || TabsBuilder).new(@context, options)
      @options = options
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

    def render(&block)
      raise LocalJumpError, "no block given" unless block_given?

      options = @options.dup
      open_tabs_options  = options.delete(:open_tabs)  || {}
      close_tabs_options = options.delete(:close_tabs) || {}

      if Railtie.rails_version < "3"
        @context.concat(open_tabs(open_tabs_options).to_s)
        yield self
        @context.concat(close_tabs(close_tabs_options).to_s)
      else
        "".tap do |html|
          html << open_tabs(open_tabs_options).to_s
          html << @context.capture(self, &block)
          html << close_tabs(close_tabs_options).to_s
        end.html_safe
      end
    end

  end

end
