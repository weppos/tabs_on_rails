require 'test_helper'

class MixinController < ActionController::Base
  def self.controller_name; "mixin"; end
  def self.controller_path; "mixin"; end

  layout false
  
  current_tab :dashboard
  current_tab :welcome,   :only => [ :action_welcome ]

  def method_missing(method, *args)
    if method =~ /^action_(.*)/
      render :action => (params[:template] || $1)
    end
  end

  def rescue_action(e) raise end
end

MixinController.view_paths = [ File.dirname(__FILE__) + "/fixtures/" ]


class ControllerMixinTest < ActiveSupport::TestCase
  
  def setup
    @controller = MixinController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_controller_should_include_current_tab_accessors
    assert_equal(nil, @controller.current_tab)
    @controller.current_tab = :footab
    assert_equal(:footab, @controller.current_tab)
  end
  
  def test_current_tab_should_be_dashboard
    get :action_dashboard, :template => 'standard'
    assert_equal(:dashboard, @controller.current_tab)
    assert_equal(%Q{<ul>
  <li><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end
  
  def test_current_tab_should_be_welcome_only_for_action_welcone
    get :action_welcome, :template => 'standard'
    assert_equal(:welcome, @controller.current_tab)
    assert_equal(%Q{<ul>
  <li><a href="/d">Dashboard</a></li>
  <li><span>Welcome</span></li>
</ul>}, @response.body)
  end


end
