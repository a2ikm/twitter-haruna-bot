require "rufus-scheduler"

module Lita
  module Handlers
    class Left < Handler
      def self.default_config(handler_config)
        handler_config.room             = nil
        handler_config.clock_at         = nil
        handler_config.sleepy_at        = nil
      end
      
      on :loaded do |payload|
        return unless config.room

        @scheduler = Rufus::Scheduler.new

        if clock_at = config.clock_at
          @scheduler.cron clock_at do
            robot.trigger :clock, room: config.room
          end
        end

        if sleepy_at = config.sleepy_at
          @scheduler.cron sleepy_at do
            robot.trigger :sleepy, room: config.room
          end
        end
      end

      on :clock do |payload|
        messages = [
          "マルマルマルマル、提督、深夜の任務、お疲れ様です！",
          "ん…マルヒトマルマル、榛名もご一緒します！眠くなんかありません！",
          "マルフタマルマル、提督、気を抜いてはいけません！榛名も頑張ります！",
          "マルサンマルマル…提督…ここは…榛名が見張りますから…先におやすみになっては…",
          "マルヨン…マルマル。提督…榛名も一緒に休んでは…鎮守府のお守りが…",
          "マルゴーマルマル。たしかに布団一組は狭いですね…。でも…榛名、暖かいです",
          "マルロクマルマル。提督、朝ですね！ 調子はいかがでしょうか？",
          "マルナナマルマル。すっかり朝です！ 提督は元気ですね。榛名も頑張ります。",
          "マルハチマルマル。提督の朝食、榛名もご一緒してもいいですか？",
          "マルキュウマルマル！ 提督、出撃の用意は整っています！",
          "ヒトマルマルマル。本日の作戦スケジュール、榛名にお任せください！",
          "ヒトヒトマルマル。提督、榛名のオススメプランです。少し…休養をとられてはいかがでしょうか",
          "ヒトフタマルマル。少し、休んでいただけますと…なぜかって…提督は忙しすぎますから。榛名のお願いです",
          "ヒトサンマルマル。提督、こうしてゆっくり榛名とお昼をいただくことも…重要な任務です、なんて",
          "ヒトヨンマルマル。艦娘たちの士気も向上しています！ 一気にうってでましょう！",
          "ヒトゴーマルマル。提督、成績が更新されますね。榛名と確認します？",
          "ヒトロクマルマル。提督、艦隊司令部の情報コメントも、榛名と更新致しましょう！",
          "ヒトナナマルマル。榛名、マイランクの前後の方のコメント、少し気になります",
          "ヒトハチマルマル。提督、日が暮れましたね。そろそろ夜の時間です",
          "ヒトキュウマルマル。提督の執務室からの夜景…榛名は大好きです",
          "フタマルマルマル。頑張って働いているドックのクレーン。榛名、ちょっとロマンを感じます。",
          "フタヒトマルマル。榛名もドックのクレーンのように働いて、提督と艦隊のお役に立てるよう、頑張りますね！",
          "フタフタマルマル。今宵は榛名、少し、おしゃべりが過ぎました。ご容赦くださいね？",
          "フタサンマルマル。提督、たまには、…早めにお休みください…ね？榛名のお願いです",
        ]

        target = Source.new(room: payload[:room])
        robot.send_message target, messages[Time.now.hour]
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
