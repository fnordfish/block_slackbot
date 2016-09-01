# BlockSlackbot

[![Build Status](https://travis-ci.org/fnordfish/block_slackbot.svg?branch=master)](https://travis-ci.org/fnordfish/block_slackbot)

BlockSlackbot is a [Rack](http://rack.rubyforge.org/) middleware that blocks [Slack](http://slack.com) crawlers which don't honor `robots.txt` files.
It does so by identifiying the crawler by it's user agent string as defined in [Slack's API documentation](https://api.slack.com/robots).

By default, BlockSlackbot will return with a `403` http status code and a body `Bad Robot`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'block_slackbot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install block_slackbot

## Usage

In your rackup file:

```ruby
# config.ru

require 'rack/block_slackbot'
use Rack::BlockSlackbot
```

In a Sinatra app:

```ruby
# my_app.rb

require 'rack/block_slackbot'
class MyApp < Sinatra::Base
  configure do
    use Rack::BlockSlackbot
```

### Custom Response

To change the blocking response, provide a Rack response array as an option like this:

```ruby
# Redirect somewhere:
use Rack::BlockSlackbot, :response => [302, { "Location" => "https://example.com" }, []]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/block_slackbot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

