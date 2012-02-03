#--
# Tabs on Rails
#
# A simple Ruby on Rails plugin for creating and managing Tabs.
#
# Copyright (c) 2009-2012 Simone Carletti <weppos@weppos.net>
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
          method.call                                     #     method.call
        else                                              #   else
          method.call(*args)                              #     method.call(*args)
        end                                               #   end
      end                                                 # end
    end

    def method_missing(*args, &block)
      @builder.tab_for(*args, &block)
    end


    # Renders the tab stack using the current builder.
    #
    # Returns the String HTML content.
    def render(&block)
      raise LocalJumpError, "no block given" unless block_given?

      options = @options.dup
      open_tabs_options  = options.delete(:open_tabs)  || {}
      close_tabs_options = options.delete(:close_tabs) || {}

      "".tap do |html|
        html << open_tabs(open_tabs_options).to_s
        html << @context.capture(self, &block)
        html << close_tabs(close_tabs_options).to_s
      end.html_safe
    end

  end

end
