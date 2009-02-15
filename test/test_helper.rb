require 'rubygems'
require 'test/unit'
require 'mocha'

require 'active_support'
require 'active_support/test_case'
require 'action_controller'
require 'action_controller/cgi_ext'
require 'action_controller/test_process'
require 'action_view/test_case'

$:.unshift File.dirname(__FILE__) + '/../lib'

# simulate the inclusion as Rails does loading the init.rb file.
require    'tabs_on_rails'
require    File.dirname(__FILE__) + '/../init.rb'

RAILS_ROOT = '.'    unless defined? RAILS_ROOT
RAILS_ENV  = 'test' unless defined? RAILS_ENV

ActionController::Base.logger = nil
ActionController::Routing::Routes.reload rescue nil

# Unit tests for Helpers are based on unit tests created and developed by Rails core team.
# See action_pack/test/abstract_unit for more details.
