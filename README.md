# Tabs on Rails

<tt>TabsOnRails</tt> is a simple Rails plugin for creating tabs and navigation menus. It provides helpers for generating navigation menus with a flexible interface.


## Requirements

- Rails 4.2 or Rails 5

For older versions of Ruby or Ruby on Rails, see the [CHANGELOG](CHANGELOG.md).


## Installation

Add this line to your application's `Gemfile`:

    gem "tabs_on_rails"

And then execute `bundle` to install the dependencies:

    $ bundle

Use [Bundler](http://bundler.io/) and the `:git` option if you want to grab the latest version from the Git repository.


## Usage

In your template use the `tabs_tag` helper to create your tab.

```ruby
<%= tabs_tag do |tab| %>
  <%= tab.home      'Homepage', root_path %>
  <%= tab.dashboard 'Dashboard', dashboard_path %>
  <%= tab.account   'Account', account_path %>
<% end %>
```

renders

```html
<ul>
  <li><a href="/">Homepage</a></li>
  <li><a href="/dashboard">Dashboard</a></li>
  <li><a href="/account">Account</a></li>
</ul>
```

The usage is similar to the Rails route file. You create named tabs with the syntax `tab.name_of_tab`. The name you use creating a tab is the same you're going to refer to in your controller when you want to mark a tab as the current tab.

```ruby
class DashboardController < ApplicationController
  set_tab :dashboard
end
```

Now, if the action belongs to `DashboardController`, the template will automatically render the following HTML code.

```html
<ul>
  <li><a href="/">Homepage</a></li>
  <li class="custom"><span>Dashboard</span></li>
  <li><a href="/account">Account</a></li>
</ul>
```

Use the `current_tab` helper method if you need to access the value of current tab in your controller or template.

```ruby
class DashboardController < ApplicationController
  set_tab :dashboard
end
```

In your view

```html
<p>The name of current tab is <%= current_tab %>.</p>
```

### Customizing a Tab

You can pass a hash of options to customize the style and the behavior of the tab item.
Behind the scenes, each time you create a tab, the `#tab_for` method is invoked.

```ruby
<%= tabs_tag do |tab| %>
  <%= tab.home      'Homepage', root_path, :style => "padding: 10px" %>
  <%= tab.dashboard 'Dashboard', dashboard_path %>
<% end %>
```

renders

```
<ul>
  <li style="padding: 10px"><a href="/">Homepage</a></li>
  <li class="custom"><span>Dashboard</span></li>
  <li><a href="/account">Account</a></li>
</ul>
```

See `TabsOnRails::Tabs::TabsBuilder#tab_for` for more details.

### Customizing `open_tabs` and `close_tabs`

The `open_tabs` and the `close_tabs` methods can be customized with the `:open_tabs` and `:close_tabs` option.

```ruby
<%= tabs_tag :open_tabs => { :id => "tabs", :class => "cool" } do |tab| %>
  <%= tab.home      'Homepage', root_path %>
  <%= tab.dashboard 'Dashboard', dashboard_path %>
  <%= tab.account   'Account', account_path %>
<% end %>
```

renders

```html
<ul id="tabs" class="cool">
  <li><a href="/">Homepage</a></li>
  <li><a href="/dashboard">Dashboard</a></li>
  <li><a href="/account">Account</a></li>
</ul>
```

Further customizations require a custom `Builder` (see below).


## Restricting `set_tab` scope

The `set_tab` method understands all options you are used to pass to a Rails controller filter.
In fact, behind the scenes this method uses a `before_filter` to store the tab in the `@tab_stack` variable.

Taking advantage of Rails filter options, you can restrict a tab to a selected group of actions in the same controller.

```ruby
class PostsController < ApplicationController
  set_tab :admin
  set_tab :posts, :only => %w(index show)
end

class ApplicationController < ActionController::Base
  set_tab :admin, :if => :admin_controller?
  
  def admin_controller?
    self.class.name =~ /^Admin(::|Controller)/
  end
end
```

## Using Namespaces to create Multiple Tabs

Namespaces enable you to create and manage tabs in parallels. The best way to demonstrate namespace usage is with an example.

Let's assume your application provides a first level navigation menu with 3 elements: `:home`, `:dashboard`, `:projects`. The relationship between your tabs and your controllers is 1:1 so you should end up with the following source code.

```ruby
class HomeController
  set_tab :home
end

class DashboardController
  set_tab :dashboard
end

class ProjectsController
  set_tab :projects
  
  def first; end
  def second; end
  def third; end
end
```

The project controller contains 3 actions and you might want to create a second-level navigation menu. This menu should reflect the navigation status of the user in the project page.

Without namespaces, you wouldn't be able to accomplish this task because you already set the current tab value to :projects. You need to create a parallel navigation menu and uniquely identify it with a custom namespace.
Let's call it :navigation.

```ruby
class ProjectsController
  set_tab :projects

  # Create an other tab navigation level
  set_tab :first, :navigation, :only => %w(first)
  set_tab :second, :navigation, :only => %w(second)
  set_tab :third, :navigation, :only => %w(third)

  def first; end
  def second; end
  def third; end
end
```

Voilà! That's all you need to do. And you can create an unlimited number of namespaces as long as you use an unique name to identify them.

The default namespace is called `:default`. Passing `:default` as name is the same as don't using any namespace at all. The following lines are equivalent.

```ruby
set_tab :projects
set_tab :projects, :default
```

### Rendering Tabs with Namespaces

To switch namespace in your template, just pass the `:namespace` option to the `tabs_tag` helper method.

```ruby
<%= tabs_tag do |tab| %>
  <%= tab.home      'Homepage', root_path %>
  <%= tab.dashboard 'Dashboard', dashboard_path %>
  <%= tab.projects  'Projects', projects_path %>
<% end %>

<%= tabs_tag :namespace => :navigation do |tab| %>
  <%= tab.first   'First', project_first_path %>
  <%= tab.second  'Second', project_second_path %>
  <%= tab.third   'Account', project_third_path %>
<% end %>
```

### Namespace scope

As a bonus feature, the namespace needs to be unique within current request scope, not necessarily across the entire application.

Back to the previous example, you can reuse the same namespace in the other controllers. In this way, you can reuse your templates as well.

```ruby
class HomeController
  set_tab :home
end

class DashboardController
  set_tab :dashboard

  set_tab :index,  :navigation, :only => %w(index)
  set_tab :common, :navigation, :only => %w(foo bar)
  
  # ...
end

class ProjectsController
  set_tab :projects

  set_tab :first,  :navigation, :only => %w(first)
  set_tab :second, :navigation, :only => %w(second)
  set_tab :third,  :navigation, :only => %w(third)
  
  # ...
end
```


## Tab Builders

The `Builder` is responsible for creating the tabs HTML code. This library is bundled with two `Builders`:

- `Tabs::Builder`: this is the abstract interface for any custom builder.
- `Tabs::TabsBuilder`: this is the default builder.

### Understanding the Builder

Builders act as formatters. A Builder encapsulates all the logic behind the tab creation including the code required to toggle tabs status.

When the `tabs_tag` helper is called, it creates a new `Tabs` instance with selected Builder. If you don't provide a custom builder, then `Tabs::TabsBuilder` is used by default.

### Creating a custom Builder

All builders must extend the base `Tabs::Builder` class and implement at least the `tab_for` method.
Additional overridable methods include:

- `open_tabs`: the method called before the tab set
- `close_tabs`: the method called after the tab set
- `tab_for`: the method called to create a single tab item

The following example creates a custom tab builder called `MenuTabBuilder`.

```ruby
class MenuTabBuilder < TabsOnRails::Tabs::Builder
  def open_tabs(options = {})
    @context.tag("ul", options, open = true)
  end

  def close_tabs(options = {})
    "</ul>".html_safe
  end

  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = (current_tab?(tab) ? 'active' : '')
    @context.content_tag(:li, item_options) do
      @context.link_to(name, options)
    end
  end
end
```

### Using a custom Builder

In your view, simply pass the builder class to the `tabs_tag` method.

```ruby
<%= tabs_tag(:builder => MenuTabBuilder) do |tab| %>
  <%= tab.home        'Homepage', root_path %>
  <%= tab.dashboard,  'Dashboard', dashboard_path %>
  <%= tab.account     'Account', account_path, :style => 'float: right;' %>
<% end %>
```

renders

```html
<ul>
  <li class=""><a href="/">Homepage</a></li>
  <li class="active"><a href="/dashboard">Dashboard</a></li>
  <li class="" style="float: right;"><a href="/account">Account</a></li>
</ul>
```


## Credits

<tt>TabsOnRails</tt> was created and is maintained by [Simone Carletti](https://simonecarletti.com/). Many improvements and bugfixes were contributed by the [open source community](https://github.com/weppos/tabs_on_rails/graphs/contributors).


## Contributing

Direct questions and discussions to [Stack Overflow](http://stackoverflow.com/questions/tagged/tabs-on-rails).

[Pull requests](https://github.com/weppos/tabs_on_rails) are very welcome! Please include tests for every patch, and create a topic branch for every separate change you make.

Report issues or feature requests to [GitHub Issues](https://github.com/weppos/tabs_on_rails/issues).


## More Information

- [Homepage](https://simonecarletti.com/code/tabs-on-rails)
- [RubyGems](https://rubygems.org/gems/tabs_on_rails)
- [Issues](https://github.com/weppos/tabs_on_rails/issues)


## License

Copyright (c) 2009-2017 Simone Carletti. This is Free Software distributed under the MIT license.
