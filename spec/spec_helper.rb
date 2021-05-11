require "bundler/setup"

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'simplecov_json_formatter'
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
  SimpleCov.start do
    add_filter %r{^/spec/}
  end
end

require 'rack/test'
require 'rspec'
require 'rspec/its'

require 'block_slackbot'
require 'rack/block_slackbot'

Dir[File.expand_path("../{fixtures,support}/**/*.rb", __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.formatter = config.files_to_run.size > 1 ? :progress : :documentation
end
