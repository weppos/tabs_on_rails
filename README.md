# Tabs on Rails

*TabsOnRails* is a simple Rails plugin for creating tabs and navigation menus. It provides helpers for generating navigation menus with a flexible interface.


## Requirements

* Rails 3

Please note 

* TabsOnRails 2.x requires Rails 3. Use TabsOnRails 1.3.x with Rails 2.
* TabsOnRails doesn't work with Rails 2.1 or lower
([comment](http://www.simonecarletti.com/blog/2009/04/tabsonrails/#comment-2901) and [commit](http://github.com/weppos/tabs_on_rails/commit/d5ae9f401e3d0acc87251fa8957a8625e90ba4b3)).


## Installation

[RubyGems](http://rubygems.org) is the preferred way to install *TabsOnRails* and the best way if you want install a stable version.

    $ gem install tabs_on_rails

Specify the Gem dependency in the [Bundler](http://gembundler.com) `Gemfile`.

    gem "tabs_on_rails"

Use [Bundler](http://gembundler.com) and the [:git option](http://gembundler.com/v1.0/git.html) if you want to grab the latest version from the Git repository.


## Usage

In your template use the `tabs_tag` helper to create your tab.

    <%= tabs_tag do |tab| %>
      <%= tab.home      'Homepage', root_path %>
      <%= tab.dashboard 'Dashboard', dashboard_path %>
      <%= tab.account   'Account', account_path %>
    <% end %>

The example above produces the following HTML output.

    <ul>
      <li><a href="/">Homepage</a></li>
      <li><a href="/dashboard">Dashboard</a></li>
      <li><a href="/account">Account</a></li>
    </ul>

The usage is similar to the Rails route file. You create named tabs with the syntax `tab.name_of_tab`. The name you use creating a tab is the same you're going to refer to in your controller when you want to mark a tab as the current tab.

Now, if the action belongs to `DashboardController`, the template will automatically render the following HTML code.

    <ul>
      <li><a href="/">Homepage</a></li>
      <li class="custom"><span>Dashboard</span></li>
      <li><a href="/account">Account</a></li>
    </ul>

Use the `current_tab` helper method if you need to access the value of current tab in your controller or template.

    class DashboardController < ApplicationController
      set_tab :dashboard
    end

    # In your view
    <p>The name of current tab is <%= current_tab %>.</p>

Read the [documentation](/code/tabs_on_rails/docs/) to learn more about advanced usage, builders and namespaces.


## Credits

* [Simone Carletti](http://www.simonecarletti.com/) <weppos@weppos.net> - The Author


## Resources

* [Homepage](http://www.simonecarletti.com/code/tabs_on_rails)
* [Documentation](http://www.simonecarletti.com/code/tabs_on_rails/docs/)
* [API](http://rubydoc.info/gems/tabs_on_rails)
* [Repository](https://github.com/weppos/tabs_on_rails)
* [Issue Tracker](http://github.com/weppos/tabs_on_rails/issues)


## License

*TabsOnRails* is Copyright (c) 2009-2012 Simone Carletti. This is Free Software distributed under the MIT license.
