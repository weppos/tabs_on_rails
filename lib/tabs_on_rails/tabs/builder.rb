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
  class Tabs

    # 
    # = Builder
    #
    # The Builder class represents the interface for any custom Builder.
    # 
    # To create a custom Builder, extend this class
    # and implement the following abstract methods:
    # 
    # * <tt>tab_for</tt>
    #
    # Optionally, you can override the following methods to customize
    # the Builder behavior:
    #
    # * <tt>open_tabs</tt>
    # * <tt>close_tabs</tt>
    #
    class Builder

      # Initializes a new builder with the given hash of <tt>options</tt>,
      # providing the current Rails template as <tt>context</tt>.
      #
      # Warning: You should not override this method to prevent incompatibility with future versions.
      def initialize(context, options = {})
        @context   = context
        @namespace = options.delete(:namespace) || :default
        @options   = options
      end

      # Returns true if +tab+ is the +current_tab+.
      #
      # Examples
      # 
      #   class MyController < ApplicationController
      #     tab :foo
      #   end
      # 
      #   current_tab? :foo   # => true
      #   current_tab? 'foo'  # => true
      #   current_tab? :bar   # => false
      #   current_tab? 'bar'  # => false
      #
      def current_tab?(tab)
        tab.to_s == @context.current_tab(@namespace).to_s
      end


      # Creates and returns a tab with given +args+.
      #
      # Raises NotImplemented: you should implement this method in your custom Builder.
      def tab_for(*args)
        raise NotImplementedError
      end

      # Override this method to use a custom open tag for your tabs.
      def open_tabs(*args)
      end

      # Override this method to use a custom close tag for your tabs.
      def close_tabs(*args)
      end

    end

  end
end
