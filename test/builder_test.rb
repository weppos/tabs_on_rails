require 'test_helper'

class BuilderTest < ActiveSupport::TestCase
  
  def setup
    @template = Template.new
    @builder  = TabsOnRails::Tabs::Builder.new(@template)
  end
  
  def test_initialize_should_require_context
    assert_raise(ArgumentError) { TabsOnRails::Tabs::Builder.new }
    assert_nothing_raised { TabsOnRails::Tabs::Builder.new(@template) }
  end
  
  def test_initialize_should_set_context
    assert_equal(@template, @builder.instance_variable_get(:'@context'))
  end
  
  def test_current_tab_question_should_return_true_if_tab_matches_current_tab
    assert( @builder.current_tab?(:dashboard))
    assert( @builder.current_tab?('dashboard'))
    assert(!@builder.current_tab?(:welcome))
    assert(!@builder.current_tab?('welcome'))
  end
  
  def test_tab_for_should_raise_not_implemented_error
    assert_raise(NotImplementedError) { @builder.tab_for }
    assert_raise(NotImplementedError) { @builder.tab_for('foo') }
    assert_raise(NotImplementedError) { @builder.tab_for('foo', 'bar') }
  end
  
end
