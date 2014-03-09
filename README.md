# SimpleBuilder

Dead-simple base class to build create/update service objects from. I got tired of reinventing something like this is every ruby/rails/sinatra app I write, so here's a gem, cruel world :).

## Installation

Add this line to your application's Gemfile:

    gem 'simple_builder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_builder

## Usage

It's quite simple. Your implementing class has to implement two methods:

1. `#new_instance`
2. `#set_attributes`

Hopefully, it is obvious what those two methods should do. `#build!` and it's alias `#update!` both call `#save` on the instance to persist the changes, so you should implement or alias that as appropriate.

The initializer optionally takes a block (to which we `yield self`) so you can do interesting things like support additional parameters or set stuff up for later.

Here are some examples, both from the world of Rails, though this does not depend on anything rails-y:

```ruby
# The simplest possible builder
class ChapterBuilder < SimpleBuilder
  def new_instance
    Chapter.new
  end

  def set_attributes
    self.object.attributes = {
      name: params[:name]
    }
  end
end
c = ChapterBuilder.build({ name: 'foo' }) # => #<Chapter id: 9, name: "foo">
ChapterBuilder.update(c, { name: 'bar' }) # => #<Chapter id: 9, name: "bar">

# A more complex example, illustrating the point of the block *and* new_instance
# Assume rails and a normal, nested-resource style controller scheme
class EventBuilder < SimpleBuilder
  attr_accessor :league

  def new_instance
    league.events.build
  end

  def set_attributes
    self.object.attributes = {
      name: params[:name],
      date: params[:date],
      category: params[:category]
    }
  end
end

event = EventBuilder.build(params[:event]) { |eb| eb.league = @league }
EventBuilder.update(event, params[:event])
```

## Why do this?

I don't like the hassle of `strong_parameters`, but I like object security. I like explicit constructors and updates in order to ensure I can write solid, comprehensive unit tests for any business logic around updating and creating business objects.

This approach lets me have strong tests, confidence that I am only accepting parameters I explicitly told it too, *and* lets me keep my controllers super-tidy.

It's a win-win-win.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/simple_builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
