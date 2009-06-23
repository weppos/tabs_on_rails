# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tabs_on_rails}
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simone Carletti"]
  s.date = %q{2009-06-23}
  s.description = %q{    TabsOnRails is a simple Ruby on Rails plugin for creating and managing Tabs.     It provides helpers for creating tabs with a flexible interface.
}
  s.email = %q{weppos@weppos.net}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "lib/tabs_on_rails/controller_mixin.rb", "lib/tabs_on_rails/tabs.rb", "lib/tabs_on_rails/version.rb", "lib/tabs_on_rails.rb", "LICENSE.rdoc", "README.rdoc"]
  s.files = ["CHANGELOG.rdoc", "init.rb", "install.rb", "lib/tabs_on_rails/controller_mixin.rb", "lib/tabs_on_rails/tabs.rb", "lib/tabs_on_rails/version.rb", "lib/tabs_on_rails.rb", "LICENSE.rdoc", "Manifest", "rails/init.rb", "Rakefile", "README.rdoc", "tabs_on_rails.gemspec", "tasks/tabs_on_rails_tasks.rake", "test/builder_test.rb", "test/controller_mixin_helpers_test.rb", "test/controller_mixin_test.rb", "test/controller_mixin_with_controller_test.rb", "test/fixtures/mixin/standard.html.erb", "test/tabs_builder_test.rb", "test/tabs_on_rails_test.rb", "test/test_helper.rb", "uninstall.rb"]
  s.homepage = %q{http://code.simonecarletti.com/tabsonrails}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Tabs_on_rails", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A simple Ruby on Rails plugin for creating and managing Tabs.}
  s.test_files = ["test/builder_test.rb", "test/controller_mixin_helpers_test.rb", "test/controller_mixin_test.rb", "test/controller_mixin_with_controller_test.rb", "test/tabs_builder_test.rb", "test/tabs_on_rails_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0.8"])
      s.add_development_dependency(%q<echoe>, [">= 3.1"])
    else
      s.add_dependency(%q<rake>, [">= 0.8"])
      s.add_dependency(%q<echoe>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8"])
    s.add_dependency(%q<echoe>, [">= 3.1"])
  end
end
