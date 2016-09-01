$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack/test'
require 'rspec'
require 'rspec/its'

require 'block_slackbot'

Dir[File.expand_path("../{fixtures,support}/**/*.rb", __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
