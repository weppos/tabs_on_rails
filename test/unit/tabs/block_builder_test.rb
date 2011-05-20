require 'test_helper'

class BlockBuilderTest < ActionView::TestCase
  tests TabsOnRails::ActionController::HelperMethods

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

  class BlockBuilder < TabsOnRails::Tabs::TabsBuilder
    def tab_for(tab, name, options, item_options = {}, &block)
      item_options[:class] = item_options[:class].to_s.split(" ").push("current").join(" ") if current_tab?(tab)
      content  = @context.link_to(name, options)
      content += @context.capture(&block) if block_given?
      @context.content_tag(:li, content, item_options)
    end
  end

  def setup
    @klass    = BlockBuilder
    @builder  = @klass.new(self)
  end

  def test_tab_for_with_block
    expected = %Q{<li class="current"><a href="http://dashboard.com/">Foo Bar</a><p>More Content</p></li>}
    actual = @builder.tab_for(:dashboard, 'Foo Bar', 'http://dashboard.com/') do
      content_tag(:p, "More Content")
    end

    assert_dom_equal expected, actual
  end
end
