require 'test_helper'

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
    
    assert_dom_equal('<span>Single</span>', content)
  end
  
  def test_tabs_tag_should_not_concat_open_tabs_when_nil
    content = tabs_tag(:builder => NilOpenBoundaryBuilder) do |t|
      concat t.single('Single', '#')
    end
    
    assert_dom_equal('<span>Single</span><br />', content)
  end
  
  def test_tabs_tag_should_not_concat_close_tabs_when_nil
    content = tabs_tag(:builder => NilCloseBoundaryBuilder) do |t|
      concat t.single('Single', '#')
    end

    assert_dom_equal('<br /><span>Single</span>', content)
  end

end
