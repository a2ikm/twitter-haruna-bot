if ENV['RACK_ENV'] !='production'
  require 'dotenv'
  Dotenv.load
end

require "active_support/core_ext"
Time.zone = "Asia/Tokyo"

Dir[File.expand_path("../extensions/*.rb", __FILE__)].each do |file|
  require file
end

Lita.deregister_handler(Lita::Handlers::Help)
Lita.deregister_handler(Lita::Handlers::Info)

Dir[File.expand_path("../handlers/*.rb", __FILE__)].each do |file|
  require file
end

Lita.configure do |config|
  config.robot.name       = 'haruna_bot_'
  config.robot.adapter    = :twitter
  config.robot.log_level  = :debug

  config.redis.url = ENV["REDISTOGO_URL"]
  config.http.port = ENV["PORT"]

  config.adapter.api_key             = ENV['API_KEY']
  config.adapter.api_secret          = ENV['API_SECRET']
  config.adapter.access_token        = ENV['ACCESS_TOKEN']
  config.adapter.access_token_secret = ENV['ACCESS_TOKEN_SECRET']

  config.handlers.left.room            = 1
  config.handlers.left.clock_at        = "0 * * * * Asia/Tokyo"
  config.handlers.left.sleepy_at       = "30 * * * * Asia/Tokyo"
end
