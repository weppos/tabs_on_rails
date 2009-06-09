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
      def open_tabs
      end
      
      # Overwrite this method to use a custom close tag for your tabs.
      def close_tabs
      end
      
    end
    
    #
    # = Tabs Builder
    # 
    # The TabsBuilder is and example of custom Builder.
    # It creates a new tab
    #
    class TabsBuilder < Builder
      
      # Implements Builder#tab_for.
      # Returns a link_to +tab+ with +name+ and +options+ if +tab+ is not the current tab,
      # a simple tab name wrapped by a span tag otherwise.
      # 
      #   current_tab? :foo   # => true
      # 
      #   tab_for :foo, 'Foo', foo_path
      #   # => <li><span>Foo</span></li>
      # 
      #   tab_for :bar, 'Bar', bar_path
      #   # => <li><a href="/link/to/bar">Bar</a></li>
      # 
      def tab_for(tab, name, options)
        content = @context.link_to_unless(current_tab?(tab), name, options) do
          @context.content_tag(:span, name)
        end
        @context.content_tag(:li, content)
      end
      
      # Implements Builder#open_tabs.
      def open_tabs
        '<ul>'
      end
      
      # Implements Builder#close_tabs.
      def close_tabs
        '</ul>'
      end
      
    end
    

    def initialize(context, options = {}, &block)
      @context = context
      @builder = (options.delete(:builder) || TabsBuilder).new(@context, options)
    end
    
    %w(open_tabs close_tabs).each do |method|
      define_method(method) do
        @builder.send(method)
      end
    end
    
    def method_missing(*args)
      @builder.tab_for(*args)
    end
    
  end

end