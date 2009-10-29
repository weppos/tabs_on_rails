require 'rubygems'
gem     'rails', '~>2.3.0'
gem     'mocha', '~>0.9.7'

# Remember! Due to some Mocha internal changes,
# Rails 2.2.x requires Mocha 0.9.5 and
# Rails 2.3.x requires Mocha 0.9.7 
# gem     'rails', '2.2.2'
# gem     'mocha', '0.9.5'

require 'test/unit'
require 'active_support'
require 'action_controller'
require 'action_view/test_case'

$:.unshift File.dirname(__FILE__) + '/../lib'
require    File.dirname(__FILE__) + '/../init.rb'

RAILS_ROOT = '.'    unless defined? RAILS_ROOT
RAILS_ENV  = 'test' unless defined? RAILS_ENV

ActionController::Base.logger = nil
ActionController::Routing::Routes.reload rescue nil


# Unit tests for Helpers are based on unit tests created and developed by Rails core team.
# See action_pack/test/abstract_unit for more details.


module ControllerTestHelpers
  private

    def controller
      @controller_proxy
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