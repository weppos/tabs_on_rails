require 'test_helper'

class TabsTest < ActiveSupport::TestCase
  
  Template = Class.new do
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper

    def current_tab(namespace)
      case namespace
        when nil, :default
          :dashboard
        when :foospace
          :footab
        else
          :elsetab
      end
    end
  end

  OpenZeroArgsBuilder = Class.new(TabsOnRails::Tabs::Builder) do
    def open_tabs
      '<ul>'
    end
  end

  CloseZeroArgsBuilder = Class.new(TabsOnRails::Tabs::Builder) do
    def close_tabs
      '</ul>'
    end
  end
  
  
  def setup
    @template = Template.new
    @klass    = TabsOnRails::Tabs
    @tabs     = @klass.new(@template)
  end
  
  
  def test_initialize
    @tabs = @klass.new(@template)
    assert_equal @template, @tabs.instance_variable_get(:"@context")
    assert_instance_of TabsOnRails::Tabs::TabsBuilder, @tabs.instance_variable_get(:"@builder")
  end
  
  def test_initialize_with_option_builder
    builder = Class.new(TabsOnRails::Tabs::TabsBuilder)
    @tabs = @klass.new(@template, :builder => builder)
    assert_equal @template, @tabs.instance_variable_get(:"@context")
    assert_instance_of builder, @tabs.instance_variable_get(:"@builder")
  end
  
  
  def test_open_tabs
    assert_equal '<ul>', @tabs.open_tabs
  end
  
  def test_open_tabs_with_options
    assert_equal '<ul class="foo">', @tabs.open_tabs(:class => "foo")
  end
  
  def test_open_tabs_should_ignore_options_if_arity_is_zero
    @tabs = @klass.new(@template, :builder => OpenZeroArgsBuilder)
    assert_nothing_raised do 
      assert_equal '<ul>', @tabs.open_tabs(:class => "foo")
    end
  end
  
  def test_close_tabs
    assert_equal '</ul>', @tabs.close_tabs
  end
  
  def test_close_tabs_with_options
    assert_equal '</ul>', @tabs.close_tabs(:class => "foo")
  end
  
  def test_open_tabs_should_ignore_options_if_arity_is_zero
    @tabs = @klass.new(@template, :builder => CloseZeroArgsBuilder)
    assert_nothing_raised do 
      assert_equal '</ul>', @tabs.close_tabs(:class => "foo")
    end
  end
  
end