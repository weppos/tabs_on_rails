require 'test_helper'

class NilBoundariesBuilder < TabsOnRails::Tabs::Builder
  def tab_for(tab, name, *args)
    @context.content_tag(:span, name)
  end
end

class NilOpenBoundaryBuilder < NilBoundariesBuilder
  def close_tabs
    '<br />'
  end
end

class NilCloseBoundaryBuilder < NilBoundariesBuilder
  def open_tabs
    '<br />'
  end
end


class ControllerMixinHelpersTest < ActionView::TestCase
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include TabsOnRails::ControllerMixin::HelperMethods
  
  def test_tabs_tag_should_raise_local_jump_error_without_block
    assert_raise(LocalJumpError) { tabs_tag }
  end
  
  def test_tabs_tag_should_not_concat_open_close_tabs_when_nil
    content = tabs_tag(NilBoundariesBuilder) do |t| 
      concat t.single('Single', '#')
    end
    
    assert_dom_equal('<span>Single</span>', content)
  end
  
  def test_tabs_tag_should_not_concat_open_tabs_when_nil
    content = tabs_tag(NilOpenBoundaryBuilder) do |t| 
      concat t.single('Single', '#')
    end
    
    assert_dom_equal('<span>Single</span><br />', content)
  end
  
  def test_tabs_tag_should_not_concat_close_tabs_when_nil
    content = tabs_tag(NilCloseBoundaryBuilder) do |t| 
      concat t.single('Single', '#')
    end

    assert_dom_equal('<br /><span>Single</span>', content)
  end

end
