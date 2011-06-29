# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tabs_on_rails}
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Simone Carletti}]
  s.date = %q{2011-06-29}
  s.description = %q{TabsOnRails is a simple Rails plugin for creating tabs and navigation menus.}
  s.email = %q{weppos@weppos.net}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{README.rdoc}]
  s.files = [%q{Rakefile}, %q{LICENSE}, %q{init.rb}, %q{.gemtest}, %q{CHANGELOG.rdoc}, %q{README.rdoc}, %q{tabs_on_rails.gemspec}, %q{lib/tabs_on_rails}, %q{lib/tabs_on_rails/action_controller.rb}, %q{lib/tabs_on_rails/railtie.rb}, %q{lib/tabs_on_rails/tabs}, %q{lib/tabs_on_rails/tabs/builder.rb}, %q{lib/tabs_on_rails/tabs/tabs_builder.rb}, %q{lib/tabs_on_rails/tabs.rb}, %q{lib/tabs_on_rails/version.rb}, %q{lib/tabs_on_rails.rb}, %q{test/test_helper.rb}, %q{test/unit}, %q{test/unit/controller_mixin_test.rb}, %q{test/unit/tabs}, %q{test/unit/tabs/block_builder_test.rb}, %q{test/unit/tabs/builder_test.rb}, %q{test/unit/tabs/tabs_builder_test.rb}, %q{test/unit/tabs_test.rb}, %q{test/views}, %q{test/views/working}, %q{test/views/working/default.html.erb}, %q{test/views/working/with_item_block.html.erb}, %q{test/views/working/with_item_options.html.erb}, %q{test/views/working/with_open_close_tabs.html.erb}]
  s.homepage = %q{http://www.simonecarletti.com/code/tabs_on_rails}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.3}
  s.summary = %q{A simple Ruby on Rails plugin for creating tabs and navigation menus.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<hanna-nouveau>, [">= 0"])
      s.add_development_dependency(%q<rails>, ["~> 3.0.6"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.10"])
    else
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<hanna-nouveau>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 3.0.6"])
      s.add_dependency(%q<mocha>, ["~> 0.9.10"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<hanna-nouveau>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 3.0.6"])
    s.add_dependency(%q<mocha>, ["~> 0.9.10"])
  end
end
