require 'rubygems'
require 'bundler'
Bundler.setup

require 'test/unit'
require 'mocha'

ENV["RAILS_ENV"] = "test"

require "active_support"
require "action_controller"
require "rails/railtie"

$:.unshift File.expand_path('../../lib', __FILE__)
require 'tabs_on_rails'

ActionController::Base.view_paths = File.join(File.dirname(__FILE__), 'views')

TabsOnRails::Routes = ActionDispatch::Routing::RouteSet.new
TabsOnRails::Routes.draw do
  match ':controller(/:action(/:id))'
end

ActionController::Base.send :include, TabsOnRails::Routes.url_helpers

class ActiveSupport::TestCase
  setup do
    @routes = TabsOnRails::Routes
  end


  def controller
    @controller_proxy ||= ControllerProxy.new(@controller)
  end

  class ControllerProxy
    def initialize(controller)
      @controller = controller
    end
    def method_missing(method, *args)
      @controller.instance_eval do
        m = method(method)
        m.call(*args)
      end
    end
  end

end
