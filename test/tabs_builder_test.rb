require 'test_helper'

class Template
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  
  def current_tab; :dashboard; end
end


class TabBuilderTest < ActiveSupport::TestCase
  
  def setup
    @template = Template.new
    @builder  = TabsOnRails::Tabs::TabsBuilder.new(@template)
  end
  
  def test_should_implement_builder
    assert_equal(TabsOnRails::Tabs::Builder, TabsOnRails::Tabs::TabsBuilder.superclass)
  end
  
  def test_tab_for_should_return_link_to_unless_current_tab
    assert_dom_equal('<li><a href="#">Welcome</a></li>', @builder.tab_for(:welcome, 'Welcome', '#'))
    assert_dom_equal('<li><a href="http://foobar.com/">Foo Bar</a></li>', @builder.tab_for(:welcome, 'Foo Bar', 'http://foobar.com/'))
  end
  
  def test_tab_for_should_return_span_if_current_tab
    assert_dom_equal('<li><span>Dashboard</span></li>', @builder.tab_for(:dashboard, 'Dashboard', '#'))
    assert_dom_equal('<li><span>Foo Bar</span></li>', @builder.tab_for(:dashboard, 'Foo Bar', '#'))
  end
  
end
