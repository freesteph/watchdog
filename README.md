# Watchdog
Watchdog is a Rails engine designed to read and present widgets, which
are simple charts with extra metadata.

![screenshot of Watchdog](https://github.com/freesteph/watchdog/raw/master/app/assets/images/screenshot.png)

It reads a YAML file in `config/widgets.yml` and will render them onto
the page. You only need to define your widgets configuration and write
the matching controllers action to provide data for them.

Example:

In your `config/widgets.yml` file:

```yaml
widgets:
  -
    id: unanswered_tickets
    title: 'Unanswered tickets'
    subtitle: 'This week'
    type: 'pie'
    group: 'zendesk'
    refresh_rate: 10
```

then in your `app/controller/zendesk_controller.rb`:

```ruby
class Watchdog::ZendeskController < ApplicationController
  def unanswered_tickets
    render json: [[3, 2], [8, 2]]
  end
end
```

And that's it! Read further for detailed instructions.

## Dummy app

If you just want to get a feel of how Watchdog works, just:

1. clone the repo;
2. run `bundle install`
3. step into the `test/dummy/` directory;
4. run `yarn`;
3. run `bundle exec rails s`;
5. navigate to `http://localhost:3000/watchdog/widgets`.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'watchdog'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install watchdog
```

## Dependencies

The engine currently supports Rails 6 and above. It requires
[`govuk-frontend`](https://github.com/alphagov/govuk-frontend/blob/master/docs/installation/installing-with-npm.md) to be loaded and available.

## Usage

### Mount the engine

In your `config/routes.rb`, add this line:

```ruby
mount Watchdog::Engine, at: '/watchdog'
```

`/watchdog` is purely arbitrary here, but we'll assume that namespace
for the rest of this guide.

### Link the assets

In your `app/assets/config/manifest.js`, add the Watchdog bundle:

```js
//= link watchdog_manifest.js
```

In a SASS file of your choice (ours is
`app/assets/stylesheets/core.css.scss`), import the Watchdog
stylesheet:

```css
@import 'watchdog/application';
```

Since Watchdog relies on `govuk-frontend` styling, make sure it is
setup and loaded before our import line.

### Setup widgets

Add a YAML file in `config/widgets.yml`. It should contain an array of
widgets under a `widgets` key like this:

```yaml
widgets:
  -
    id: unanswered_tickets
    title: 'Unanswered tickets'
    subtitle: 'This week'
    type: 'pie'
    group: 'zendesk'
    refresh_rate: 10
  -
    id: answered_tickets
    title: 'Answered tickets'
    subtitle: 'This week'
    type: 'line'
    group: 'zendesk'
    style: 'wide'
```

Watchdog will automatically pick up these when you start your app, so
make sure you restart your app if you operate any changes in it.

### Setup actions

Every widget needs a data source, and that data source is inferred by
Watchdog: it looks for a controller named after the widget's `group`
property, then calls the action matching the widget's `id` property.

In the sample YAML file above, the first widget will look for a
`ZendeskController` and try to call `unanswered_tickets` on it to get
data. So go ahead and write a controller for it:

```ruby
class Watchdog::ZendeskController < ApplicationController
  def unanswered_tickets
    render json: [[2, 3], [3, 4], [4, 5]]
  end
end
```

Don't forget to declare your controller within the `Watchdog::`
namespace.

The controller infering is done with Rails's own inflector so you
could have an `antique_road_show` group that would map to
`Watchdog::AntiqueRoadShowController`.

### Contemplate widgets
That's it! Navigate to `localhost:3000/watchdog/widgets` to see the
result.

Note that how you provide data to your widgets is entirely up to you.

## Widget properties

Each widget in the YAML config file can sport the following
properties:

| name         | type   | required? | description                                                                                                                       |
|--------------|--------|-----------|-----------------------------------------------------------------------------------------------------------------------------------|
| **id**       | string | X         | Identifier. Requires a matching action defined on the relevant controller.                                                        |
| **group**    | string | X         | Group this widget belongs to. Indicates which controller to look for.                                                             |
| **type**     | string | X         | a type of chart to render. See the [Chartkick documentation](https://github.com/ankane/chartkick#charts) for the available types. |
| title        | string |           | a title for your widget.                                                                                                          |
| subtitle     | string |           | a subtitle for your widget.                                                                                                       |
| refresh_rate | number |           | how often should the widget fetch and re-render data, in seconds. By default, it will not refresh automatically.                  |
| style        | string |           | an optional space-separated list of CSS classes to apply to your widget. Current option is 'wide'.                                |


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
