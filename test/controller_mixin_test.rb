require 'test_helper'

class ControllerMixinTest < ActionController::TestCase
  include ControllerTestHelpers

  class MixinController < ActionController::Base
  end

  def setup
    @controller       = MixinController.new
    @controller_proxy = ControllerProxy.new(@controller)
    @request          = ActionController::TestRequest.new
    @response         = ActionController::TestResponse.new
  end


  def test_set_tab
    controller.set_tab :footab
    assert_equal(:footab, controller.tab_stack[:default])
  end

  def test_set_tab_with_namespace
    controller.set_tab :footab, :namespace
    assert_equal(:footab, controller.tab_stack[:namespace])
  end

  def test_set_tab_with_default_namespace
    controller.set_tab :footab, :default
    assert_equal(:footab, controller.tab_stack[:default])
  end

  def test_set_tab_with_and_without_namespace
    controller.set_tab :firsttab
    controller.set_tab :secondtab, :custom
    assert_equal(:firsttab, controller.tab_stack[:default])
    assert_equal(:secondtab, controller.tab_stack[:custom])
  end


  def test_current_tab
    controller.tab_stack[:default] = :mytab
    assert_equal(:mytab, controller.current_tab)
  end

  def test_current_tab_with_namespace
    controller.tab_stack[:namespace] = :mytab
    assert_equal(:mytab, controller.current_tab(:namespace))
  end

  def test_current_tab_with_default_namespace
    controller.tab_stack[:default] = :mytab
    assert_equal(:mytab, controller.current_tab(:default))
  end

  def test_set_tab_with_and_without_namespace
    controller.tab_stack[:default] = :firsttab
    controller.tab_stack[:custom] = :secondtab
    assert_equal(:firsttab, controller.current_tab(:default))
    assert_equal(:secondtab, controller.current_tab(:custom))
  end


  def test_current_tab_question
    controller.tab_stack[:default] = :mytab
    assert( controller.current_tab?(:mytab))
    assert(!controller.current_tab?(:yourtab))
  end

  def test_current_tab_question_with_namespace
    controller.tab_stack[:custom] = :mytab
    assert( controller.current_tab?(:mytab, :custom))
    assert(!controller.current_tab?(:yourtab, :custom))
  end

  def test_current_tab_question_with_default_namespace
    controller.tab_stack[:default] = :mytab
    assert( controller.current_tab?(:mytab, :default))
    assert(!controller.current_tab?(:yourtab, :default))
  end

  def test_current_tab_question_with_and_without_namespace
    controller.tab_stack[:default] = :firsttab
    controller.tab_stack[:custom] = :secondtab
    assert( controller.current_tab?(:firsttab, :default))
    assert(!controller.current_tab?(:secondtab, :default))
    assert( controller.current_tab?(:secondtab, :custom))
    assert(!controller.current_tab?(:firsttab, :custom))
  end

end


class ControllerMixinHelpersTest < ActionView::TestCase
  tests TabsOnRails::ControllerMixin::HelperMethods
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  MockBuilder = Class.new(TabsOnRails::Tabs::Builder) do
    def initialize_with_mocha(*args)
      checkpoint
      initialize_without_mocha(*args)
    end
    alias_method_chain :initialize, :mocha

    def checkpoint
    end

    def tab_for(tab, name, *args)
    end
  end

  NilBoundariesBuilder = Class.new(TabsOnRails::Tabs::Builder) do
    def tab_for(tab, name, *args)
      @context.content_tag(:span, name)
    end
  end

  NilOpenBoundaryBuilder = Class.new(NilBoundariesBuilder) do
    def close_tabs(options = {})
      '<br />'
    end
  end

  NilCloseBoundaryBuilder = Class.new(NilBoundariesBuilder) do
    def open_tabs(options = {})
      '<br />'
    end
  end


  def test_tabs_tag_should_raise_local_jump_error_without_block
    assert_raise(LocalJumpError) { tabs_tag }
  end
  
  def test_tabs_tag_with_builder
    MockBuilder.any_instance.expects(:checkpoint).once
    tabs_tag(:builder => MockBuilder) {}
  end

  def test_tabs_tag_with_namespace
    MockBuilder.any_instance.expects(:checkpoint).once
    tabs_tag(:builder => MockBuilder, :namespace => :custom) do |tabs|
      builder = tabs.instance_variable_get(:'@builder')
      assert_equal(:custom, builder.instance_variable_get(:'@namespace'))
    end
  end


  def test_tabs_tag_should_not_concat_open_close_tabs_when_nil
    content = tabs_tag(:builder => NilBoundariesBuilder) do |t| 
      concat t.single('Single', '#')
    end

    assert_dom_equal '<span>Single</span>', content
  end

  def test_tabs_tag_should_not_concat_open_tabs_when_nil
    content = tabs_tag(:builder => NilOpenBoundaryBuilder) do |t|
      concat t.single('Single', '#')
    end

    assert_dom_equal '<span>Single</span><br />', content
  end

  def test_tabs_tag_should_not_concat_close_tabs_when_nil
    content = tabs_tag(:builder => NilCloseBoundaryBuilder) do |t|
      concat t.single('Single', '#')
    end

    assert_dom_equal '<br /><span>Single</span>', content
  end

end


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
    assert_dom_equal(%Q{<ul>
  <li class="current"><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end

  def test_render_with_open_close_tabs
    get :action_dashboard, :template => "with_open_close_tabs"
    assert_dom_equal(%Q{<ul id="tabs">
  <li class="current"><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end

  def test_render_with_item_options
    get :action_dashboard, :template => "with_item_options"
    assert_dom_equal(%Q{<ul id="tabs">
  <li class="custom current"><span>Dashboard</span></li>
  <li class="custom"><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end


  def test_set_tab
    get :action_dashboard
    assert_equal(:dashboard, controller.current_tab)
    assert_equal(:dashboard, controller.current_tab(:default))
    assert_dom_equal(%Q{<ul>
  <li class="current"><span>Dashboard</span></li>
  <li><a href="/w">Welcome</a></li>
</ul>}, @response.body)
  end

  def test_set_tab_with_only_option
    get :action_welcome
    assert_equal(:welcome, controller.current_tab)
    assert_equal(:welcome, controller.current_tab(:default))
    assert_dom_equal(%Q{<ul>
  <li><a href="/d">Dashboard</a></li>
  <li class="current"><span>Welcome</span></li>
</ul>}, @response.body)
  end

  def test_set_tab_with_namespace
    get :action_namespace
    assert_equal(:dashboard, controller.current_tab)
    assert_equal(:dashboard, controller.current_tab(:default))
    assert_equal(:homepage, controller.current_tab(:namespace))
    assert_dom_equal(%Q{<ul>
  <li class="current"><span>Dashboard</span></li>
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
