require 'test/unit'
require 'mocha'
require 'dummy'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'tabs_on_rails'


class ActiveSupport::TestCase
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
