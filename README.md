# One45

Ruby bindings for the [one45 API](https://api.one45.com/api/docs/all).

Under development since most endpoints remain listed as `Early Access/In Development`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'one45'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install one45

## Usage

Add your school credentials. In a Rails application create a new initializer `config/initializers/one45.rb`

```
One45.api_host      = ENV['ONE45_API_HOST']
One45.client_key    = ENV['ONE45_CLIENT_KEY']
One45.client_secret = ENV['ONE45_CLIENT_SECRET']
One45.access_token  = ENV['ONE45_ACCESS_TOKEN'] # optional
```

A request for a new token will be made prior to each call if no access token provided (which is slowing down response time).
In future, an alternate solution would be to implement OAuth2 strategy.

### Retrieving a collection of objects (users, groups, forms...)

```
One45::Evaluations.list(
  target_id: 111,
  target_role_id: 3,
  evaluator_role_id: 2,
  completed_on: "2015-01-01|2015-12-31",
  event_category: "rotation",
  limit: 100
)
```

### Retrieving a single object

Fetch specific record by its One45 ID

```
One45::Questions.find(504)
```

### Entities Implemented

Entity | Methods
--     | --
Evaluation | list, find, answers, contributors, question_answers
Form | list, find, groups, questions
Group | list, find, subgroups
Question | list, find
Rotation | list, find
User | list, find, preferences, todos, evaluations

__Current limits__

- Support for GET methods only at the moment (POST, DELETE, PATCH, PUT are excluded)
- Regarding token entity, only token#generate method is implemented through `One45.generate_token(One45.client_key, One45.client_secret)`

For complete implementation please refer to the test file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

You need to set up credentials to run the tests. Clone and rename `application.sample.rb` under `test/config`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/uOttawaMedtech/one45-ruby.
