require 'sinatra/github'
require 'sinatra/base'
require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class App < Sinatra::Base
  set :raise_errors, true
  set :dump_errors, false
  set :show_exceptions, false

  register Sinatra::Github

  github :commit_comment do
    status 200
  end
end

describe App do
  include Rack::Test::Methods

  def app
    App
  end

  it 'matches a commit comment' do
    post '/', {'comment'=>''}.to_json
    expect(last_response.status).to eq 200
  end

end

