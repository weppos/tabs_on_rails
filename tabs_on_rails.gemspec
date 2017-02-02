# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tabs_on_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "tabs_on_rails"
  spec.version       = TabsOnRails::VERSION
  spec.authors       = ["Simone Carletti"]
  spec.email         = ["weppos@weppos.net"]

  spec.summary       = %q{A simple Ruby on Rails plugin for creating tabs and navigation menu}
  spec.description   = %q{TabsOnRails is a simple Ruby on Rails plugin for creating tabs and navigation menu for a Rails project.}
  spec.homepage      = "https://simonecarletti.com/code/tabs-on-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "rails", ">= 4.2"
  spec.add_development_dependency "mocha", ">= 1.0"
  spec.add_development_dependency "yard"
end
