# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tabs_on_rails}
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simone Carletti"]
  s.date = %q{2011-02-13}
  s.description = %q{    TabsOnRails is a simple Ruby on Rails plugin for creating and managing Tabs.     It provides helpers for creating tabs with a flexible interface.
}
  s.email = %q{weppos@weppos.net}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.rdoc"]
  s.files = ["Rakefile", "LICENSE", "init.rb", ".gemtest", "CHANGELOG.rdoc", "README.rdoc", "tabs_on_rails.gemspec", "lib/tabs_on_rails/action_controller.rb", "lib/tabs_on_rails/railtie.rb", "lib/tabs_on_rails/tabs/builder.rb", "lib/tabs_on_rails/tabs/tabs_builder.rb", "lib/tabs_on_rails/tabs.rb", "lib/tabs_on_rails/version.rb", "lib/tabs_on_rails.rb", "test/tabs_on_rails/controller_mixin_test.rb", "test/tabs_on_rails/tabs/builder_test.rb", "test/tabs_on_rails/tabs/tabs_builder_test.rb", "test/tabs_on_rails/tabs_test.rb", "test/test_helper.rb", "test/views/working/default.html.erb", "test/views/working/with_item_options.html.erb", "test/views/working/with_open_close_tabs.html.erb"]
  s.homepage = %q{http://www.simonecarletti.com/code/tabs_on_rails}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{A simple Ruby on Rails plugin for creating and managing Tabs.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rails>, ["= 3.0.3"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.10"])
    else
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rails>, ["= 3.0.3"])
      s.add_dependency(%q<mocha>, ["~> 0.9.10"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rails>, ["= 3.0.3"])
    s.add_dependency(%q<mocha>, ["~> 0.9.10"])
  end
end
