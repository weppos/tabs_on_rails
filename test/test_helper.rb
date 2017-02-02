require 'minitest/autorun'
require 'mocha/setup'
require 'dummy'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'tabs_on_rails'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8


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
