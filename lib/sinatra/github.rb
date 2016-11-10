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
      @@apps[app][path] ||= {}
    end

    def github(event, path='/', &block)
      Github.events(self, path)[Event[event]] = block

      post path do
        result = nil
        Github.events(self.class, request.path_info).each do |e,b|
          if e.matches(payload)
            result = instance_eval(&b)
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

    class Ping < Event
      def matches(payload)
        !!payload['zen']
      end
    end

    class Push < Event
      def matches(payload)
        !!payload['commits']
      end
    end

    class PullRequest < Event
      def matches(payload)
        !!payload['pull_request'] && !payload['comment'] && !payload['review']
      end
    end

    class Event
      class << self
        @@events.tap do |e|
          e[:commit_comment] = CommitComment.new
          e[:ping] = Ping.new
          e[:push] = Push.new
          e[:pull_request] = PullRequest.new
        end
      end
    end
  end
end
