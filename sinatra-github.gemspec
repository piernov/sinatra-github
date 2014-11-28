# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/github/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-github"
  spec.version       = Sinatra::Github::VERSION
  spec.authors       = ["Michael Shea"]
  spec.email         = %w'mike.shea@gmail.com' 
  spec.summary       = %q{Sinatra Github webhook extension}
  spec.homepage      = "http://github.com/sheax0r/sinatra-github"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~>3.0'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rack-test', '~> 0.6'

  spec.add_dependency 'sinatra', '~> 1.4'
end
