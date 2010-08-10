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
      base.extend     ClassMethods
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
      # Examples
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
        # Examples
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
        # Examples
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

      # In your template use the <tt>tabs_tag</tt> helper to create your tab.
      #
      #   <% tabs_tag do |tab| %>
      #     <%= tab.home      'Homepage', root_path %>
      #     <%= tab.dashboard 'Dashboard', dashboard_path %>
      #     <%= tab.account   'Account', account_path %>
      #   <% end %>
      #
      # The example above produces the following HTML output.
      #
      #   <ul>
      #     <li><a href="/">Homepage</a></li>
      #     <li><a href="/dashboard">Dashboard</a></li>
      #     <li><a href="/account">Account</a></li>
      #   </ul>
      #
      # The usage is similar to the Rails route file.
      # You create named tabs with the syntax <tt>tab.name_of_tab</tt>.
      #
      # The name you use creating a tab is the same you're going to refer to in your controller
      # when you want to mark a tab as the current tab.
      #
      #   class DashboardController < ApplicationController
      #     set_tab :dashboard
      #   end
      #
      # Now, if the action belongs to <tt>DashboardController</tt>,
      # the template will automatically render the following HTML code.
      # 
      #   <ul>
      #     <li><a href="/">Homepage</a></li>
      #     <li class="custom"><span>Dashboard</span></li>
      #     <li><a href="/account">Account</a></li>
      #   </ul>
      #
      # Use the <tt>current_tab</tt> helper method if you need to access
      # the value of current tab in your controller or template.
      #
      #   class DashboardController < ApplicationController
      #     set_tab :dashboard
      #   end
      #
      #   # In your view
      #   <p>The name of current tab is <%= current_tab %>.</p>
      #
      # === Customizing a Tab
      #
      # You can pass a hash of options to customize the style and the behavior of the tab item.
      # Behind the scenes, each time you create a tab, the <tt>#tab_for</tt> 
      # method is invoked.
      #
      #   <% tabs_tag do |tab| %>
      #     <%= tab.home      'Homepage', root_path, :style => "padding: 10px" %>
      #     <%= tab.dashboard 'Dashboard', dashboard_path %>
      #   <% end %>
      #
      #   <ul>
      #     <li style="padding: 10px"><a href="/">Homepage</a></li>
      #     <li class="custom"><span>Dashboard</span></li>
      #     <li><a href="/account">Account</a></li>
      #   </ul>
      #
      # You can pass any option supported by the <li>content_tag</li> Rails helper.
      # Additionally, the following options have a special meaning:
      #
      # * <tt>link_current</tt>: forces the current tab to be a link, instead of a span tag
      #
      # See <tt>TabsOnRails::Tabs::TabsBuilder#tab_for</tt> for more details.
      #
      # === Customizing open_tabs and close_tabs
      #
      # The open_tabs and the close_tabs methods can be customized 
      # with the <tt>:open_tabs</tt> and <tt>:close_tabs</tt> option.
      #
      #   <% tabs_tag :open_tabs => { :id => "tabs", :class => "cool" } do |tab| %>
      #     <%= tab.home      'Homepage', root_path %>
      #     <%= tab.dashboard 'Dashboard', dashboard_path %>
      #     <%= tab.account   'Account', account_path %>
      #   <% end %>
      #
      #   <ul id="tabs" class="cool">
      #     <li><a href="/">Homepage</a></li>
      #     <li><a href="/dashboard">Dashboard</a></li>
      #     <li><a href="/account">Account</a></li>
      #   </ul>
      #
      # Further customizations require a custom <tt>Builder</tt>.
      #
      def tabs_tag(options = {}, &block)
        Tabs.new(self, { :namespace => :default }.merge(options)).render(&block)
      end

    end
  end
end
