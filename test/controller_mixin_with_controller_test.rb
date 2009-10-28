require 'test_helper'

class ControllerMixinWithControllerTest < ActionController::TestCase
  include ControllerTestHelpers
  
  class MixinController < ActionController::Base
    def self.controller_name; "mixin"; end
    def self.controller_path; "mixin"; end

    layout false

    set_tab :dashboard
    set_tab :welcome,   :only => %w(action_welcome)
    set_tab :dashboard, :only => %w(action_namespace)
    set_tab :homepage,  :namespace, :only => %w(action_namespace)

    def method_missing(method, *args)
      if method =~ /^action_(.*)/
        render :action => (params[:template] || 'default')
      end
    end

    def rescue_action(e) raise end
  end

  MixinController.view_paths = [ File.dirname(__FILE__) + "/fixtures/" ]

  def setup
    @controller = MixinController.new
    @controller_proxy = ControllerProxy.new(@controller)
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end


  def test_render_default
    get :action_dashboard
    assert_equal(%Q{<ul>
  <li><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end

  def test_render_with_open_close_tabs
    get :action_dashboard, :template => "with_open_close_tabs"
    assert_equal(%Q{<ul id="tabs">
  <li><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end


  def test_set_tab
    get :action_dashboard
    assert_equal(:dashboard, controller.current_tab)
    assert_equal(:dashboard, controller.current_tab(:default))
    assert_equal(%Q{<ul>
  <li><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end

  def test_set_tab_with_only_option
    get :action_welcome
    assert_equal(:welcome, controller.current_tab)
    assert_equal(:welcome, controller.current_tab(:default))
    assert_equal(%Q{<ul>
  <li><a href="/d">Dashboard</a></li>
  <li><span>Welcome</span></li>
</ul>}, @response.body)
  end

  def test_set_tab_with_namespace
    get :action_namespace
    assert_equal(:dashboard, controller.current_tab)
    assert_equal(:dashboard, controller.current_tab(:default))
    assert_equal(:homepage, controller.current_tab(:namespace))
    assert_equal(%Q{<ul>
  <li><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end


  def test_current_tab
    get :action_dashboard
    assert_equal :dashboard, controller.current_tab
    assert_equal :dashboard, controller.current_tab(:default)
  end

  def test_current_tab_question
    get :action_dashboard
    assert  controller.current_tab?(:dashboard)
    assert  controller.current_tab?(:dashboard, :default)
    assert !controller.current_tab?(:foobar)
    assert !controller.current_tab?(:foobar, :default)
  end

end
