require 'test_helper'

class BuilderTest < ActionView::TestCase

  def setup
    @template = self
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
  end


  def test_initialize_without_context
    assert_raise(ArgumentError) { TabsOnRails::Tabs::Builder.new }
  end

  def test_initialize_with_context
    assert_nothing_raised { TabsOnRails::Tabs::Builder.new(@template) }
  end

  def test_initialize_with_options
    assert_nothing_raised { TabsOnRails::Tabs::Builder.new(@template, { :namespace => "foonamespace" }) }
  end

  def test_initialize_should_set_context
    assert_equal @template, @builder.instance_variable_get(:"@context")
  end

  def test_initialize_should_set_namespace
    @builder = TabsOnRails::Tabs::Builder.new(@template)
    assert_equal :default, @builder.instance_variable_get(:"@namespace")

    @builder = TabsOnRails::Tabs::Builder.new(@template, :namespace => :foobar)
    assert_equal :foobar, @builder.instance_variable_get(:"@namespace")
  end

  def test_initialize_should_set_current
    @builder = TabsOnRails::Tabs::Builder.new(@template)
    assert_equal 'current', @builder.instance_variable_get(:"@current")

    @builder = TabsOnRails::Tabs::Builder.new(@template, :current => 'active')
    assert_equal 'active', @builder.instance_variable_get(:"@current")
  end

  def test_initialize_should_set_options
    @builder = TabsOnRails::Tabs::Builder.new(@template)
    assert_equal({}, @builder.instance_variable_get(:"@options"))

    @builder = TabsOnRails::Tabs::Builder.new(@template, :weather => :sunny)
    assert_equal({ :weather => :sunny }, @builder.instance_variable_get(:"@options"))

    @builder = TabsOnRails::Tabs::Builder.new(@template, :namespace => :foobar, :weather => :sunny)
    assert_equal({ :weather => :sunny }, @builder.instance_variable_get(:"@options"))

    @builder = TabsOnRails::Tabs::Builder.new(@template, :namespace => :foobar)
    assert_equal({}, @builder.instance_variable_get(:"@options"))
  end


  def test_current_tab
    @builder = TabsOnRails::Tabs::Builder.new(@template)
    assert  @builder.current_tab?(:dashboard)
    assert  @builder.current_tab?("dashboard")
    assert !@builder.current_tab?(:welcome)
    assert !@builder.current_tab?("welcome")
  end

  def test_current_tab_with_namespace
    @builder = TabsOnRails::Tabs::Builder.new(@template, :namespace => :foospace)
    assert  @builder.current_tab?(:footab)
    assert  @builder.current_tab?("footab")
    assert !@builder.current_tab?(:dashboard)
    assert !@builder.current_tab?("dashboard")
  end


  def test_open_tabs
    assert_equal nil, @builder.open_tabs
  end

  def test_open_tabs_with_options
    assert_equal nil, @builder.open_tabs(:foo => "bar")
  end

  def test_close_tabs
    assert_equal nil, @builder.close_tabs
  end

  def test_close_tabs_with_options
    assert_equal nil, @builder.close_tabs(:foo => "bar")
  end


  def test_tab_for_should_raise_not_implemented_error
    assert_raise(NotImplementedError) { @builder.tab_for }
    assert_raise(NotImplementedError) { @builder.tab_for("foo") }
    assert_raise(NotImplementedError) { @builder.tab_for("foo", "bar") }
  end

end
