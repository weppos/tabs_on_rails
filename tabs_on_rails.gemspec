# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "tabs_on_rails"
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simone Carletti"]
  s.date = "2012-02-03"
  s.description = "TabsOnRails is a simple Rails plugin for creating tabs and navigation menus."
  s.email = "weppos@weppos.net"
  s.files = ["Rakefile", "LICENSE", "init.rb", ".gemtest", "CHANGELOG.rdoc", "README.rdoc", "tabs_on_rails.gemspec", "lib/tabs_on_rails", "lib/tabs_on_rails/action_controller.rb", "lib/tabs_on_rails/railtie.rb", "lib/tabs_on_rails/tabs", "lib/tabs_on_rails/tabs/builder.rb", "lib/tabs_on_rails/tabs/tabs_builder.rb", "lib/tabs_on_rails/tabs.rb", "lib/tabs_on_rails/version.rb", "lib/tabs_on_rails.rb", "test/functionals", "test/test_helper.rb", "test/unit", "test/unit/controller_mixin_test.rb", "test/unit/tabs", "test/unit/tabs/block_builder_test.rb", "test/unit/tabs/builder_test.rb", "test/unit/tabs/tabs_builder_test.rb", "test/unit/tabs_test.rb", "test/views", "test/views/working", "test/views/working/default.html.erb", "test/views/working/with_item_block.html.erb", "test/views/working/with_item_options.html.erb", "test/views/working/with_open_close_tabs.html.erb"]
  s.homepage = "http://www.simonecarletti.com/code/tabs_on_rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "A simple Ruby on Rails plugin for creating tabs and navigation menus."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>, [">= 3.0"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.10"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0"])
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<mocha>, ["~> 0.9.10"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0"])
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<mocha>, ["~> 0.9.10"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
