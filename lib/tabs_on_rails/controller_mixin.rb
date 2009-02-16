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
# SVN: $Id$
#++


module TabsOnRails
  
  module ControllerMixin
    
    def self.included(base)
      base.extend         ClassMethods
      base.send :helper,  HelperMethods
      base.class_eval do
        attr_accessor :current_tab
        helper_method :current_tab
      end
    end

    module ClassMethods

      # Sets +name+ as +current_tab+.
      # 
      # ==== Examples
      # 
      #   tab :foo
      #   tab :foo, :except => :new
      #   tab :foo, :only => [ :index, :show ]
      # 
      def current_tab(name, options = {})
        before_filter(options) do |controller|
          controller.current_tab = name
        end
      end

    end

    module HelperMethods

      def tabs_tag(builder = nil, &block)
        raise LocalJumpError, "no block given" unless block_given?
        tabs  = Tabs.new(self, builder)

        concat(tabs.open_tabs.to_s)
        yield  tabs
        concat(tabs.close_tabs.to_s)
      end

    end
  end
end