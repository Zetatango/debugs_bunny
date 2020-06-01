# DebugsBunny

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/debugs_bunny`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'debugs_bunny'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install debugs_bunny

Once it is installed, you can automatically generate relevant files using:

    $ rails generate debugs_bunny:install

## Usage

Once installed, Traces can be created in the following manner: 

```ruby
dump = {}
dump[:authentication] = request&.authentication
dump[:args] = context[:args]
dump[:cassette_name] = context[:cassette_name]
dump[:endpoint] = endpoint.class.name
dump[:error] = response&.error&.name
dump[:error_message] = response&.error_message
dump[:headers] = request&.headers
dump[:http_code] = response&.http_code
dump[:http_method] = endpoint.class.http_method
dump[:outgoing_request_id] = request&.id
dump[:payload] = request&.payload
dump[:response] = response&.body
dump[:retries] = context[:retries] || 0
dump[:url] = endpoint.url

json = dump.to_json
trace = DebugTrace.create(dump: json)
```

DebugsBunny provides a Rake task to automatically clear Traces older than the configured lifetime:

    $ rake debugs_bunny:delete_expired_traces
    
The Trace lifetime can be configured by the application. By default, this is set in the generated `debugs_bunny.rb` initializer:

```ruby
DebugsBunny.configuration.max_age = 1.week
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/debugs_bunny.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
