$:.unshift(File.dirname(__FILE__) + "/lib")

require 'rubygems'
require 'rake'
require 'echoe'
require 'tabs_on_rails'


PKG_NAME    = ENV['PKG_NAME']    || TabsOnRails::GEM
PKG_VERSION = ENV['PKG_VERSION'] || TabsOnRails::VERSION
RUBYFORGE_PROJECT = nil

if ENV['SNAPSHOT'].to_i == 1
  PKG_VERSION << "." << Time.now.utc.strftime("%Y%m%d%H%M%S")
end


Echoe.new(PKG_NAME, PKG_VERSION) do |p|
  p.author        = "Simone Carletti"
  p.email         = "weppos@weppos.net"
  p.summary       = "A simple Ruby on Rails plugin for creating and managing Tabs."
  p.url           = "http://code.simonecarletti.com/tabsonrails"
  p.description   = <<-EOD
    TabsOnRails is a simple Ruby on Rails plugin for creating and managing Tabs. \
    It provides helpers for creating tabs with a flexible interface.
  EOD
  p.project       = RUBYFORGE_PROJECT

  p.need_zip      = true

  p.development_dependencies += ["rake  ~>0.8.7",
                                 "echoe ~>3.2.0"]

  p.rcov_options  = ["-Itest -x Rakefile,rcov,json,mocha,rack,actionpack,activesupport"]
end


begin
  require 'code_statistics'
  desc "Show library's code statistics"
  task :stats do
    CodeStatistics.new(["TabsOnRails", "lib"],
                       ["Tests", "test"]).to_s
  end
rescue LoadError
  puts "CodeStatistics (Rails) is not available"
end
