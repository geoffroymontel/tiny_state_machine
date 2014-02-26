# TinyStateMachine

Yet another state machine for Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'tiny_state_machine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tiny_state_machine

## Usage

```ruby
sm = TinyStateMachine::Machine.new :in_store do |sm|
  sm.event :buy, :in_store => :new
  sm.event :use, :new => :used
  sm.event :use, :used => :used
  sm.event :break, :used => :broken
  sm.event :fix, :broken => :used
  sm.on_state_change do |event, from_state, to_state|
    puts "new state = #{to_state}"
  end
end

sm.trigger(:buy)
# new state = new
# => :new

sm.trigger(:buy)
# TinyStateMachine::InvalidEvent: Invalid event 'buy' from state 'new'

sm.trigger(:use)
# new state = used
# => :used

sm.state
# => :used

sm.trigger(:use)
# new state = used
# => :used
```

## Tests

```bash
bundle install # to install rspec
bundle exec rspec # to run tests
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author
Copyright (c) 2014 Geoffroy Montel (@g_montel)
MIT License
