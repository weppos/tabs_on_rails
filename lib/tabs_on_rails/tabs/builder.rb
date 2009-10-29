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
    # To create a custom Builder extend this class 
    # and implement the following abstract methods:
    # 
    # * tab_for(args)
    #
    class Builder

      # Initializes a new builder with +context+.
      #
      # Note. You should not overwrite this method to prevent incompatibility with future versions.
      def initialize(context, options = {})
        @context   = context
        @namespace = options.delete(:namespace) || :default
      end

      # Returns true if +tab+ is the +current_tab+.
      #
      # ==== Examples
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
      # ==== Raises
      # 
      # NotImplemented:: you should implement this method in your custom Builder.
      # 
      def tab_for(*args)
        raise NotImplementedError
      end

      # Overwrite this method to use a custom open tag for your tabs.
      def open_tabs(*args)
      end

      # Overwrite this method to use a custom close tag for your tabs.
      def close_tabs(*args)
      end

    end

  end
end