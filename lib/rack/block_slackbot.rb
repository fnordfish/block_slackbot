# frozen_string_literal: true
require "rack"

class Rack::BlockSlackbot
  # Pattern to match Slack's robots. Documentation here:
  # https://api.slack.com/robots
  SLACKBOT_UA_PATTERN = /\ASlack(bot-LinkExpanding|-ImgProxy|bot) /.freeze

  DEFAULT_RESPONSE = [
    403,
    { "Content-Type" => "text/plain" }.freeze,
    ["Bad Robot"].freeze
  ].freeze

  HTTP_USER_AGENT = "HTTP_USER_AGENT".freeze

  def initialize(app, options = {})
    @app = app
    @response = options.fetch(:response, DEFAULT_RESPONSE)
  end

  def call(env)
    if block?(env)
      @response
    else
      @app.call(env)
    end
  end

  def block?(env)
    env[HTTP_USER_AGENT] && env[HTTP_USER_AGENT] =~ SLACKBOT_UA_PATTERN
  end
end
