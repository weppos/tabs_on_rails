require 'test_helper'

class TabsBuilderTest < ActionView::TestCase

  def setup
    @builder  = TabsOnRails::Tabs::TabsBuilder.new(self)
  end

  def test_inherits_from_builder
    assert_equal TabsOnRails::Tabs::Builder, TabsOnRails::Tabs::TabsBuilder.superclass
  end


  def test_open_tabs
    assert_dom_equal %Q{<ul>}, @builder.open_tabs
  end

  def test_open_tabs_with_options
    assert_dom_equal %Q{<ul style="foo">}, @builder.open_tabs(:style => "foo")
  end

  def test_close_tabs
    assert_dom_equal %Q{</ul>}, @builder.close_tabs
  end

  def test_close_tabs_with_options
    assert_dom_equal %Q{</ul>}, @builder.close_tabs(:foo => "bar")
  end


  def test_tab_for_should_return_link_to_unless_current_tab
    assert_dom_equal %Q{<li><a href="#">Welcome</a></li>},
                     @builder.tab_for(:welcome, 'Welcome', '#')
    assert_dom_equal %Q{<li><a href="#">Foo Welcome</a></li>},
                     @builder.tab_for(:welcome, 'Foo Welcome', '#')
  end

  def test_tab_for_should_return_span_if_current_tab
    assert_dom_equal %Q{<li class="current"><span>Dashboard</span></li>},
                     @builder.tab_for(:dashboard, 'Dashboard', '#')
    assert_dom_equal %Q{<li class="current"><span>Foo Dashboard</span></li>},
                     @builder.tab_for(:dashboard, 'Foo Dashboard', '#')
  end

  def test_tab_for_with_options_as_uri
    assert_dom_equal %Q{<li><a href="http://welcome.com/">Foo Bar</a></li>},
                     @builder.tab_for(:welcome, 'Foo Bar', 'http://welcome.com/')
    assert_dom_equal %Q{<li class="current"><span>Foo Bar</span></li>},
                     @builder.tab_for(:dashboard, 'Foo Bar', 'http://dashboard.com/')
  end

  def test_tab_for_with_item_options
    assert_dom_equal %Q{<li class="custom current"><span>Dashboard</span></li>},
                     @builder.tab_for(:dashboard, "Dashboard", "#", :class => "custom")
    assert_dom_equal %Q{<li class="custom"><a href="#">Welcome</a></li>},
                     @builder.tab_for(:welcome, "Welcome", "#", :class => "custom")
    assert_dom_equal %Q{<li style="padding: 10px" class="current"><span>Dashboard</span></li>},
                     @builder.tab_for(:dashboard, "Dashboard", "#", :style => "padding: 10px")
    assert_dom_equal %Q{<li style="padding: 10px"><a href="#">Welcome</a></li>},
                     @builder.tab_for(:welcome, "Welcome", "#", :style => "padding: 10px")
  end

end
