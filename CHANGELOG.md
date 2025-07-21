# Changelog

## main

- FIXED: Frozen string warning (GH-43)


## Release 3.0.0

- CHANGED: Compatible with Rails 5.
- CHANGED: Dropped support for Rails before 4.2 and Ruby before 2.2.


## Release 2.2.0

* NEW: Ability to configure a default builder (GH-20). [Thanks @ilstar]

* NEW: Ability to pass a custom value for the "active" class (GH-23). [Thanks @ruurd]


## Release 2.1.1

* FIXED: An invalid replace command caused a bug in 2.1.0.


## Release 2.1.0

* NEW: Support for Rails 3.2.

* FIXED: Fixed Rails 3.2 ActiveSupport::Concern deprecation warning (GH-18).


## Release 2.0.2

* NEW: Added support for nested tabs and ability
  to pass a block to the #tab_for method (#12, #9, #11).

  However, the default TabsBuilder builder does not implement it.
  Create a custom builder and specify how the block should be rendered.

* CHANGED: Removed deprecated #has_rdoc= RubyGems attribute.


## Release 2.0.1

* NEW: Added support for rubygems-test.


## Release 2.0.0

Nothing changed. No longer a --pre release.


## Release 2.0.0.pre2

* FIXED: Fixed permission error (#8)


## Release 2.0.0.pre

* CHANGED: Dropped support for Rails 2.

* CHANGED: Remove "Incomplete `close_tabs' definition" warning. open_tabs/close_tabs can now have zero or more arguments.


## Release 1.3.2

* CHANGED: Use Bundler to declare dependencies.

* FIXED: Some Rails 2 user can experience a NoMethodError: undefined method `html_safe'.


## Release 1.3.1

* FIXED: Error wrong number of arguments (2 for 3) (closes #3)


## Release 1.3.0

* NEW: Ability to customize the behavior and the style of the li tab item
         passing a hash of options.

           <%= tabs_tag do |tab| %>
             <%= tab.home      'Homepage', root_path, :style => "padding: 10px" %>
             <%= tab.dashboard 'Dashboard', dashboard_path %>
           <% end %>
           
           <ul>
             <li style="padding: 10px"><a href="/">Homepage</a></li>
             <li class="custom"><span>Dashboard</span></li>
             <li><a href="/account">Account</a></li>
           </ul>


## Release 1.2.0

* NEW: Rails 3 compatibility.

* CHANGED: Simplified tabs_tag helper by moving the rendering logic into TabsOnRails::Tabs#render.

* CHANGED: TabsOnRails::Tabs::Builder (and all child classes) now has full access to @options hash.


## Release 1.1.0

* FIXED: Incompatibility with release < 1.0.0 caused by open_tabs and close_tabs methods changes compared to 0.8.0.

* CHANGED: Removed BUILD and STATUS constants. Added Version::ALPHA constant to be used when I need to package prereleases (see RubyGem --prerelease flag).

* CHANGED: Removed empty install/uninstall hooks and tasks folder.

* CHANGED: Removed rails/init hook because deprecated in Rails 3.

* CHANGED: Drop dependency from Echoe. Change Rakefile to use custom tasks.

* REMOVED: Deleted empty install.rb file.


## Release 1.0.0

* NEW: Ability to pass arbitrary options to open_tabs and close_tags method. Thanks to aaronchi (closes #315)

* REMOVED: tabs_tag no longer accepts a Builder as first parameter. Removed deprecation warning.

First stable release.


## Release 0.8.2

* CHANGED: GitHub Gem Building is Defunct. The gem is now hosted on Gemcutter (see http://github.com/blog/515-gem-building-is-defunct)


## Release 0.8.1

* CHANGED: Controller#set_tab now uses #send instead of #instance_eval (better performance and more security)

* CHANGED: run test against Rails ~> 2.3.0 but ensure compatibility with Rails 2.2.x.


## Release 0.8.0

* FIXED: Invalid usage of the word namescope instead of namespace.

* FIXED: :current_tab? not available as helper method (closes #229).

* FIXED: GitHub now requires the Manifest file to be included in the repos.

* FIXED: Controller methods should be protected/private (closes #228).

* CHANGED: Status to Beta and bumped release (closes #227).

* REMOVED: Deprecated current_tab setter method. Use set_tab instead.


## Release 0.3.0

* NEW: Support for namespaces in order to manage concurrent tab menus (closes #144).

* FIXED: `Uninitialized constant RAILS_DEFAULT_LOGGER (NameError)' error message when running tests outside a Rails environment.

* FIXED: Tests complains when Rails 2.3.2 is installed. This library is 100% compatible with Rails 2.3.2 but for now let's force tests to use Rails 2.2.2.

* CHANGED: current_tab= controller instance/class methods are now deprecated. Use set_tab instead.

* CHANGED: Calling tabs_tag with a custom builder as first parameter is now deprecated. Use :builder option instead.


## Release 0.2.0

* NEW: The README file is definitely more useful now, filled up with some basic documentation.

* CHANGED: Use the standard way to initialize a Rails plugin when packaged as a GEM (closes #146).

* CHANGED: Removed development version warning (closes #145).


## Release 0.1.0

* Initial version
