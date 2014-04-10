# TutoMan

TutoMan manages diplays of tutorial views or reminders in a rails application.

## Installation

Add this line to your application's Gemfile:

    gem 'tuto_man'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tuto_man

## Usage

### Configuration

Set display timing for each tutorial or reminders.

```ruby
# config/initializers/tuto_man.rb
TutoMan :my_tuto, interval: 7 * 24 * 60 * 60  # once shown suppress for 1 week
```

### Control

```ruby
# tell if a tuto is displaying
tuto(:my_tuto).on?

# mark as shown
tuto(:my_tuto).shown

# turn off forever
tuto(:my_tuto).off
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/tuto_man/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
