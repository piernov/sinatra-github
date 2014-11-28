# Sinatra::Github

Sinatra Github webhook extension, for handling github webhook payloads.

This gem has not reached a releasable state yet. Stay tuned!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-github'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-github

## Usage
Register the extension in your sinatra application, then use the new "github" DSL method.
For example:
```ruby
require 'sinatra/base'
require 'sinatra/github'

class MyApp < Sinatra::Base
  # Matches github commit comments. 
  # Payload is available as parsed JSON, via the "payload" method. 
  # https://developer.github.com/v3/activity/events/types/#commitcommentevent
  github :commit_comment, '/webhook'
    puts payload['comment']['url']  
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sinatra-github/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
