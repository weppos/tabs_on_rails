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