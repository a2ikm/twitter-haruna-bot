module Lita
  module Handlers
    class Followed < Handler
      on :followed, :follow_back

      @@client = ::Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["API_KEY"]
        config.consumer_secret     = ENV["API_SECRET"]
        config.access_token        = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
      end

      def follow_back(payload)
        user = payload[:user]
        @@client.follow(user.name)
      end
    end
    Lita.register_handler(Followed)
  end
end
