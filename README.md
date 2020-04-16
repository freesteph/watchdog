# Watchdog
Watchdog is a Rails engine designed to read and present widgets, which
are simple charts with extra metadata.

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

Add a c

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
