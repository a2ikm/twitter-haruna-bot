module Lita
  module Handlers
    class Favorited < Handler
      on :favorited, :im_happy!
      def im_happy!(payload)
        return if rand(2) == 0
        target = Source.new(room: 1)
        robot.send_message(
          target,
          [
            "榛名、感激です！",
            "力を感じます。お心遣い、ありがとうございます。",
          ].sample
        )
      end
    end
    Lita.register_handler(Favorited)
  end
end
