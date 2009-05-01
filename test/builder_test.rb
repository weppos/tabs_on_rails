require 'test_helper'

class BuilderTemplate
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


class BuilderTest < ActiveSupport::TestCase
  
  def setup
    @template = BuilderTemplate.new
  end
  

  def test_initialize_should_require_context
    assert_raise(ArgumentError) { TabsOnRails::Tabs::Builder.new }
    assert_nothing_raised { TabsOnRails::Tabs::Builder.new(@template) }
  end
  
  def test_initialize_should_allow_options
    assert_nothing_raised { TabsOnRails::Tabs::Builder.new(@template, { :namespace => 'foonamespace' }) }
  end

  def test_initialize_should_set_context
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
    assert_equal(@template, @builder.instance_variable_get(:'@context'))
  end

  def test_initialize_should_set_namespace
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
    assert_equal(:default, @builder.instance_variable_get(:'@namespace'))

    @builder  = TabsOnRails::Tabs::Builder.new(@template, :namespace => :foobar)
    assert_equal(:foobar, @builder.instance_variable_get(:'@namespace'))
  end


  def test_current_tab
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
    assert( @builder.current_tab?(:dashboard))
    assert( @builder.current_tab?('dashboard'))
    assert(!@builder.current_tab?(:welcome))
    assert(!@builder.current_tab?('welcome'))
  end

  def test_current_tab_with_namespace
    @builder  = TabsOnRails::Tabs::Builder.new(@template, :namespace => :foospace)
    assert( @builder.current_tab?(:footab))
    assert( @builder.current_tab?('footab'))
    assert(!@builder.current_tab?(:dashboard))
    assert(!@builder.current_tab?('dashboard'))
  end


  def test_open_tabs
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
    assert_equal(nil, @builder.open_tabs)
  end

  def test_close_tabs
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
    assert_equal(nil, @builder.close_tabs)
  end


  def test_tab_for_should_raise_not_implemented_error
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
    assert_raise(NotImplementedError) { @builder.tab_for }
    assert_raise(NotImplementedError) { @builder.tab_for('foo') }
    assert_raise(NotImplementedError) { @builder.tab_for('foo', 'bar') }
  end
  
end
