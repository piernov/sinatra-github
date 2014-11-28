require 'sinatra/base'
require "sinatra/github/version"
require 'json'


module Sinatra
  module Github
    @@apps = {}

    module Helpers
      def payload
        @payload ||= JSON.parse(request.body.read.to_s)
      end
    end

    def self.registered(app)
      app.helpers Github::Helpers 
    end

    def self.events(app, path)
      @@apps[app] ||= {}
      @@apps[app][path] ||= [] 
    end

    def github(event, path='/', &block)
      Github.events(self, path) << Event[event]

      post path do
        result = nil
        Github.events(self.class, request.path_info).each do |e|
          if e.matches(payload)
            result = instance_eval(&block)
          end
        end
        result
      end
    end

    class Event
      @@events={}
      def self.[](sym)
        @@events[sym] || (fail "No event type: #{sym}")
      end
    end

    class CommitComment < Event
      def matches(payload)
        !!payload['comment'] && !payload['issue'] && !payload['pull_request']
      end
    end

    class Event
      class << self
        @@events.tap do |e|
          e[:commit_comment] = CommitComment.new
        end
      end
    end
  end
end
