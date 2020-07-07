# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'block_slackbot/version'

Gem::Specification.new do |spec|
  spec.name          = "block_slackbot"
  spec.version       = BlockSlackbot::VERSION
  spec.authors       = ["Robert Schulze"]
  spec.email         = ["robert@dotless.de"]

  spec.summary       = %q{A Rack Middleware to block Slackbot requests}
  spec.description   = %q{Slackbot does not honor robots.txt, this Middleware will return a HTTP 403 error response}
  spec.homepage      = "https://github.com/fnordfish/block_slackbot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack", ">= 1.3"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its", "~> 1.0"
  spec.add_development_dependency "rack-test", "~> 1.1"
end
