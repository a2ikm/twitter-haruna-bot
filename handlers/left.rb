require "rufus-scheduler"

module Lita
  module Handlers
    class Left < Handler
      def self.default_config(handler_config)
        handler_config.room             = nil
        handler_config.night_battle_at  = nil
        handler_config.sleepy_at        = nil
      end
      
      on :loaded do |payload|
        return unless config.room

        @scheduler = Rufus::Scheduler.new

        if night_battle_at = config.night_battle_at
          @scheduler.cron night_battle_at do
            robot.trigger :night_battle, room: config.room
          end
        end

        if sleepy_at = config.sleepy_at
          @scheduler.cron sleepy_at do
            robot.trigger :sleepy, room: config.room
          end
        end
      end

      on :night_battle do |payload|
        target = Source.new(room: payload[:room])
        robot.send_message(target, "夜戦なの？腕がなるわね！")
      end

      on :sleepy do |payload|
        return unless rand(2) == 0

        target = Source.new(room: payload[:room])
        messages = [
          "榛名、待機命令…了解です…。",
          "いいのでしょうか？榛名がお休みしてて…。",
        ]
        robot.send_message(target, messages.sample)
      end

      private

        def config
          Lita.config.handlers.left
        end
    end

    Lita.register_handler(Left)
  end
end
