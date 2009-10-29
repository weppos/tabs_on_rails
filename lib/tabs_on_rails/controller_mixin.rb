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
  
  module ControllerMixin
    
    def self.included(base)
      base.extend         ClassMethods
      base.class_eval do
        include       InstanceMethods
        helper        HelperMethods
        helper_method :current_tab, :current_tab?
      end
    end

    module ClassMethods

      # Sets the value for current tab to given name.
      #
      #   set_tab :foo
      #
      # If you need to manage multiple tabs, then you can pass an optional namespace.
      #
      #   set_tab :foo, :namespace
      #
      # The <tt>set_tab</tt> method understands all options you are used to pass to a Rails controller filter.
      # In fact, behind the scenes this method uses a <tt>before_filter</tt>
      # to store the tab in the <tt>@tab_stack</tt> variable.
      # For example, you can set the tab only for a restricted group of actions in the same controller
      # using the <tt>:only</tt> and <tt>:except</tt> options.
      #
      # ==== Examples
      # 
      #   set_tab :foo
      #   set_tab :foo, :except => :new
      #   set_tab :foo, :only => [ :index, :show ]
      #
      #   set_tab :foo, :namespace
      #   set_tab :foo, :namespace, :only => [ :index, :show ]
      #
      def set_tab(*args)
        options = args.extract_options!
        name, namespace = args
        
        before_filter(options) do |controller|
          controller.send(:set_tab, name, namespace)
        end
      end

    end

    module InstanceMethods
      protected

        # Sets the value for current tab to given name.
        # If you need to manage multiple tabs, then you can pass an optional namespace.
        #
        # ==== Examples
        #
        #   set_tab :homepage
        #   set_tab :dashboard, :menu
        #
        def set_tab(name, namespace = nil)
          tab_stack[namespace || :default] = name
        end

        # Returns the value for current tab in the default namespace,
        # or nil if no tab has been set before.
        # You can pass <tt>namespace</tt> to get the value of current tab for a different namespace.
        #
        # ==== Examples
        #
        #   current_tab           # => nil
        #   current_tab :menu     # => nil
        #
        #   set_tab :homepage
        #   set_tab :dashboard, :menu
        #
        #   current_tab           # => :homepage
        #   current_tab :menu     # => :dashboard
        #
        def current_tab(namespace = nil)
          tab_stack[namespace || :default]
        end

        # Returns whether the current tab in <tt>namespace</tt> matches <tt>name</tt>.
        def current_tab?(name, namespace = nil)
          current_tab(namespace).to_s == name.to_s
        end

        # Initializes and/or returns the tab stack.
        # You won't probably need to use this method directly
        # unless you are trying to hack the plugin architecture.
        def tab_stack
          @tab_stack ||= {}
        end

    end

    module HelperMethods

      def tabs_tag(options = {}, &block)
        raise LocalJumpError, "no block given" unless block_given?
        
        options = options.dup
        open_tabs_options  = options.delete(:open_tabs)  || {}
        close_tabs_options = options.delete(:close_tabs) || {}
        tabs = Tabs.new(self, { :namespace => :default }.merge(options))

        concat(tabs.open_tabs(open_tabs_options).to_s)
        yield  tabs
        concat(tabs.close_tabs(close_tabs_options).to_s)
      end

    end
  end
end