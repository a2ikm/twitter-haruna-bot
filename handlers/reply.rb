module Lita
  module Handlers
    class Reply < Handler
      route /大丈夫？/, :all_right!
      def all_right!(message)
        return unless message.user.metadata["mention"]
        message.reply_with_mention "榛名は大丈夫です！"
      end

      on :unhandled_message, :i_cant_understand
      def i_cant_understand(payload)
        message = payload[:message]
        return unless message.user.metadata["mention"]
        message.reply_with_mention "すみません、なにをおっしゃってるかわかりません…。提督、大丈夫ですか…？"
      end
    end

    Lita.register_handler(Reply)
  end
end
